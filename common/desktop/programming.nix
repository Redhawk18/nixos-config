{
  config,
  lib,
  pkgs,
  ...
}:
{

  config = lib.mkIf config.desktop.programming {
    environment.systemPackages = with pkgs; [
      dbeaver-bin
      jetbrains.idea-ultimate
      vscode
    ];
  };
}
