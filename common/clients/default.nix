{ lib, ... }:
{
  imports = [
    ./nfs.nix
    ./tailscale.nix
  ];

  options = {
    nfs = lib.mkEnableOption "enable nfs client";
    tailscale = lib.mkEnableOption "enable tailscale";
  };
}
