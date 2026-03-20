{ lib, ... }:
{
  imports = [
    ./nfs.nix
    ./tailscale.nix
    ./syncthing.nix
  ];

  options = {
    nfs = lib.mkEnableOption "enable nfs client";
    syncthing = lib.mkEnableOption "enable syncthing";
    tailscale = lib.mkEnableOption "enable tailscale";
  };
}
