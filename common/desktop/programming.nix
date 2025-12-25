{
  config,
  lib,
  pkgs,
  pure,
  ...
}:
{

  config = lib.mkIf config.desktop.programming {
    environment.systemPackages = [
      # pkgs.# blender
      pkgs.dbeaver-bin
      pkgs.distrobox
      pkgs.inlyne
      pkgs.jetbrains.idea
      pkgs.texliveFull
      pkgs.texstudio
      pkgs.neovim
      pkgs.rustdesk-flutter
      pkgs.vscode
    ];

    # Cross compiling
    boot.binfmt.emulatedSystems = [
      "aarch64-linux"
    ];

  };

}
