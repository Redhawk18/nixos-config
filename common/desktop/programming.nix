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
      pkgs.distrobox
      pkgs.inlyne
      pkgs.texliveFull
      pkgs.texstudio
      pkgs.neovim
      pkgs.vscode
    ];

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.direnv.angrr.enable = true;

  };
}
