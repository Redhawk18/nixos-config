{ lib, ... }:
{
  imports = [
    ./ai.nix
    ./nfs.nix
    ./tailscale.nix
    ./syncthing.nix
  ];

  options = {
    ai = lib.mkEnableOption "enable ai tools";
    nfs = lib.mkEnableOption "enable nfs client";
    syncthing = lib.mkEnableOption "enable syncthing";
    tailscale = lib.mkEnableOption "enable tailscale";
  };
}
