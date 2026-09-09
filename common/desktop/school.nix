{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.desktop.school {
    environment.systemPackages = [
      pkgs.jetbrains.idea
    ];
  };
}
