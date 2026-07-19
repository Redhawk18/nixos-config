{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.desktop.programming {
    environment.systemPackages = [
      pkgs.blender
      pkgs.cargo-clean-recursive
      pkgs.dbeaver-bin
      pkgs.distrobox
      pkgs.inlyne
      # pkgs.jetbrains.idea
      pkgs.texliveFull
      pkgs.texstudio
      pkgs.neovim
      # pkgs.rustdesk-flutter
      pkgs.vscode
    ];

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

  };
}
