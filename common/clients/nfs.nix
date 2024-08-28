{ config, lib, ... }: {
  config = lib.mkIf config.nfs {
    fileSystems."/mnt/paisley-park" = {
      device = "paisley-park.lan:/boundman/server_files";
      fsType = "nfs";
      options = [
        "noauto"
        "nofail"
        # This *may* not be needed
        "rsize=1048576"
        "wsize=1048576"
        "x-systemd.automount"
        "x-systemd.idle-timeout=300"
      ];
    };
  };
}
