{
  fileSystems."/mnt/paisley-park" = {
    device = "paisley-park.lan:/boundman/server_files";
    fsType = "nfs";
    options = [
      "noauto"
      "rsize=1048576"
      "wsize=1048576"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };
}
