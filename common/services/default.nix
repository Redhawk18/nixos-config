{ lib, ... }:
{
  imports = [
    ./printing.nix
    ./xmrig.nix
  ];

  options = {
    printing = lib.mkEnableOption "enable printer services";
    xmrig = lib.mkEnableOption "enable xmrig services";
  };
}
