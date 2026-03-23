{ lib, ... }:
{
  imports = [
    ./gitea-runner.nix
    ./printing.nix
    ./xmrig.nix
  ];

  options = {
    gitera-runner = lib.mkEnableOption "enable gitera runner(s)";
    printing = lib.mkEnableOption "enable printer services";
    xmrig = lib.mkEnableOption "enable xmrig services";
  };
}
