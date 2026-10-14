{ config, lib, ... }:
{
  config = lib.mkIf config.nfs {
    fileSystems."/mnt/paisley-park" = {
      device = "paisley-park:/boundman/server_files";
      fsType = "nfs";
      options = [
        "noauto"
        "nofail"
        # This *may* not be needed
        "rsize=1048576"
        "wsize=1048576"
        "x-systemd.automount"
        "x-systemd.idle-timeout=300"
        # "x-systemd.after=network-online.target"
        # The server drops off the tailnet for hours at a time. Without these a
        # `hard` mount retries forever, so anything touching the mount (a shell
        # whose cwd is under it, ~/Music) blocks with no timeout. Fail out after
        # ~25s instead: timeo is in deciseconds, retried `retrans` times.
        "soft"
        "timeo=50"
        "retrans=3"
      ];
    };
    fileSystems."/mnt/paisley-park_tailscale" = {
      device = "paisley-park.tailfa9236.ts.net:/boundman/server_files";
      fsType = "nfs";
      options = [
        "noauto"
        "nofail"
        # This *may* not be needed
        "rsize=1048576"
        "wsize=1048576"
        "x-systemd.automount"
        "x-systemd.idle-timeout=300"
        # "x-systemd.after=network-online.target"
        "soft"
        "timeo=50"
        "retrans=3"
      ];
    };

  };
}
