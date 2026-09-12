{ lib, unstable, ... }:
let
  dataDir = "/boundman/romm";
  romsDir = "/boundman/server_files/Roms";
  libraryRoms = "${dataDir}/library/roms";
  secretsFile = "/var/lib/romm/secrets.env";
in
{
  # services.romm only exists in unstable; nixos-26.05 has neither the module
  # nor the romm/rahasher packages.
  imports = [ (unstable.path + "/nixos/modules/services/web-apps/romm.nix") ];

  nixpkgs.overlays = [
    (_final: _prev: { inherit (unstable) romm rahasher; })
  ];

  services.romm = {
    enable = true;

    # Only runtime data (resources/assets/config/cache) lives here; the ROM
    # library itself is bind-mounted in below.
    inherit dataDir;

    # Metadata provider credentials (IGDB_CLIENT_ID, IGDB_CLIENT_SECRET,
    # SCREENSCRAPER_USER, ...). Filled in by hand, never in the repo.
    environmentFile = secretsFile;

    nginx.virtualHost = "romm.paisley-park";

    # The module derives this from the vhost name and drops the port.
    extraEnvironment.ROMM_BASE_URL = "http://paisley-park:8083";
  };

  # Upstream fixes the library at <dataDir>/library and expects the platform
  # folders under <library>/roms, so the existing collection gets bind-mounted
  # into that slot rather than moved.
  fileSystems.${libraryRoms} = {
    device = romsDir;
    fsType = "none";
    options = [
      "bind"
      # /boundman is a zfs pool mounted by zfs-mount.service rather than a
      # fileSystems entry, so the fstab generator has no idea it has to wait.
      # Without this the bind can land on an empty directory at boot.
      "x-systemd.requires=zfs-mount.service"
    ];
  };

  # Likewise, don't let RomM scan the library before the bind mount is there.
  systemd.services =
    lib.genAttrs
      [
        "romm"
        "romm-worker"
        "romm-scheduler"
        "romm-watcher"
      ]
      (_: {
        unitConfig.RequiresMountsFor = [ libraryRoms ];
      });

  # The ROMs are nobody:media; joining the group lets RomM write back into
  # them (uploads, renames) instead of only reading.
  users.users.romm.extraGroups = [ "media" ];

  # systemd refuses to start the unit if the EnvironmentFile is missing, so
  # make sure an (empty) one exists without clobbering the real secrets.
  systemd.tmpfiles.settings."10-romm-secrets" = {
    "/var/lib/romm".d = {
      mode = "0700";
      user = "root";
      group = "root";
    };
    ${secretsFile}.f = {
      mode = "0600";
      user = "root";
      group = "root";
    };
  };

  # LAN/Tailscale only, matching how the other services here are reached.
  services.nginx.virtualHosts."romm.paisley-park".listen = [
    {
      addr = "0.0.0.0";
      port = 8083;
    }
  ];
}
