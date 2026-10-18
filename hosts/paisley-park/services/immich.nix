{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:
let
  # The dataset inherits its mountpoint from the pool, so boundman/immich lands
  # on /boundman/immich without a `mountpoint` property.
  dataset = "boundman/immich";
  mediaLocation = "/boundman/immich";

  inherit (config.services.immich) user group;

  syncoidUnit = "syncoid-" + builtins.replaceStrings [ "/" ] [ "-" ] dataset;

  # Snapshot and replication both run here. 2am local: systemd timers honour
  # time.timeZone, even though sanoid itself is forced to TZ=UTC upstream so a
  # DST jump cannot swallow a snapshot.
  snapshotTime = "*-*-* 02:00:00";

  # Replication stays inert until this is filled in. syncoid needs an ssh key
  # below plus `zfs allow ... create,mount,receive` on the far side, so there is
  # nothing to point it at yet. Set it to "user@host:pool/dataset" and the
  # service turns itself on.
  syncoidTarget = null;
in
{
  services.immich = {
    enable = true;
    inherit mediaLocation;

    # nixos-26.05 ships immich 2.7.5, which nixpkgs marks insecure: 2.x is EOL
    # upstream and carries CVE-2026-59258 / CVE-2026-82272. The 3.x line only
    # exists in unstable, and the module differs only in documentation between
    # the two channels, so just the package is pulled forward.
    #
    # Taking it from the `unstable` specialArg also keeps it clear of this
    # host's `nixpkgs.config.cudaSupport = true`, which would otherwise force a
    # from-source onnxruntime build for machine-learning.
    package = unstable.immich;

    # LAN/Tailscale only, matching how romm and the arr stack are reached here.
    # No nginx in front on purpose: the mobile app uploads whole videos in a
    # single request, so a reverse proxy only adds a body-size limit to trip
    # over.
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;

    # Left explicit: `null` keeps every knob editable in the admin UI. Setting
    # anything here bakes a read-only config.json and greys that page out.
    settings = null;
  };

  # The database is shared with romm's postgres (forgejo is on sqlite). Immich
  # adds pgvector + vectorchord and a shared_preload_libraries entry, so the
  # first switch restarts postgresql and romm goes down with it briefly.
  # services.postgresql.package is still pinned to 14 by stateVersion 23.05,
  # which immich supports.

  # Snapshots. Enabled here because this library is the one thing on the pool
  # that is not re-downloadable; other datasets can be added to `datasets`.
  # These live on the same disks as the data, so they cover fat-finger deletes,
  # a bad upgrade, or immich eating its own library -- not loss of the pool.
  # That is what syncoid is for.
  #
  # Keeping immich on its own dataset is what makes this possible at all:
  # snapshotting boundman wholesale would pin every file torrent-cleaner
  # deletes (it runs with DRY_RUN=false and no per-run cap), so the pool would
  # stop reclaiming space.
  services.sanoid = {
    enable = true;
    interval = snapshotTime;

    templates.immich = {
      # sanoid only acts when it runs, and the timer fires once a day, so
      # anything sub-daily could never be satisfied.
      hourly = 0;
      daily = 30;
      monthly = 12;
      yearly = 3;

      autosnap = true;
      autoprune = true;
    };

    datasets.${dataset}.useTemplate = [ "immich" ];
  };

  services.syncoid = {
    enable = syncoidTarget != null;
    interval = snapshotTime;

    # Where the key goes once there is a target to reach; syncoid runs as its
    # own system user with /var/lib/syncoid as $HOME.
    # sshKey = "/var/lib/syncoid/.ssh/id_ed25519";

    commands.${dataset} = {
      # `source` defaults to the attribute name.
      target = lib.optionalString (syncoidTarget != null) syncoidTarget;

      # -L pairs with recordsize=1M below: without it zfs send chops blocks
      # larger than 128K apart on the wire instead of streaming them as-is.
      sendOptions = "L";
    };
  };

  systemd.services = lib.mkMerge [
    {
      # Nothing in NixOS manages zfs datasets declaratively, so this is the
      # closest thing: idempotent, ordered ahead of immich, and it keeps the
      # property choices next to the service that depends on them.
      immich-dataset = {
        description = "Create and tune the ZFS dataset backing Immich's media";

        # /boundman is mounted by zfs-mount.service rather than a fileSystems
        # entry. RequiresMountsFor is no help here -- boundman.mount only
        # exists once the mount does -- so depend on the service instead.
        requires = [ "zfs-mount.service" ];
        after = [ "zfs-mount.service" ];

        before = [
          "immich-server.service"
          "immich-machine-learning.service"
        ];
        requiredBy = [
          "immich-server.service"
          "immich-machine-learning.service"
        ];
        wantedBy = [ "multi-user.target" ];

        # /run/booted-system rather than pkgs.zfs: the userland tools have to
        # match the kernel module actually loaded, which after a switch without
        # a reboot is still the previous generation's. Same reasoning the
        # sanoid and syncoid modules use.
        path = [
          "/run/booted-system/sw"
          pkgs.coreutils
        ];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        script = ''
          if ! zfs list -H -o name ${dataset} > /dev/null 2>&1; then
            # compression=off: this is already-compressed heic/jpeg/h265, so
            #   the pool's zstd-6 would only burn cpu on every import.
            # recordsize=1M: large media in fewer blocks. It is a maximum, not
            #   a fixed size, so thumbnails still land in small blocks. Needs
            #   the large_blocks feature, which this pool has enabled.
            # atime=off: immich re-reads the library constantly, and there is
            #   no reason to turn each of those reads into a metadata write.
            # xattr=sa + dnodesize=auto: keep extended attributes in the dnode
            #   instead of a hidden directory, the usual advice on Linux.
            zfs create \
              -o compression=off \
              -o recordsize=1M \
              -o atime=off \
              -o xattr=sa \
              -o dnodesize=auto \
              ${dataset}
          fi

          # A fresh dataset root is root:root 0755 and immich wants 0700. The
          # module only ships an adjust-if-exists tmpfiles rule, which runs too
          # early to see the mount, so fix ownership here.
          install -d -o ${user} -g ${group} -m 0700 ${mediaLocation}
        '';
      };
    }

    # Both timers fire on the same minute; make the send wait for the snapshot
    # it is meant to be sending rather than shipping yesterday's.
    (lib.mkIf (syncoidTarget != null) {
      ${syncoidUnit}.after = [ "sanoid.service" ];
    })
  ];
}
