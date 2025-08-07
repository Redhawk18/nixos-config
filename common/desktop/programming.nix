{
  config,
  lib,
  pkgs,
  ...
}:
{

  config = lib.mkIf config.desktop.programming {
    environment.systemPackages = with pkgs; [
      blender
      dbeaver-bin
      jetbrains.idea-ultimate
      neovim
      vscode
    ];
  };
}
