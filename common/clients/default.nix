{ lib, ... }:
{
  imports = [ ./nfs.nix ];

  options = {
    nfs = lib.mkEnableOption "enable nfs client";
  };
}
