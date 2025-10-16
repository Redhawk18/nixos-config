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
      inlyne
      jetbrains.idea-ultimate
      neovim
      rustdesk-flutter
      vscode
    ];
  };
}
