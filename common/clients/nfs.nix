{ pkgs, ... }:
{
  # environment.systemPackages = with pkgs; [ nfs-utils ];

  # boot.initrd = {
  #  supportedFilesystems = [ "nfs" ];
  #  kernelModules = [ "nfs" ];
  # };

  fileSystems."/mnt/paisley-park" = {
    device = "paisley-park.lan:/boundman/server_files";
    fsType = "nfs";
    options = [ "x-systemd.automount" "x-systemd.idle-timeout=600" "noauto" ];
  };
}
