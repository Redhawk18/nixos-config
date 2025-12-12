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
      distrobox
      inlyne
      jetbrains.idea-ultimate
      texliveFull
      texstudio
      neovim
      rustdesk-flutter
      vscode
    ];

    # Cross compiling
    boot.binfmt.emulatedSystems = [
      "aarch64-linux" # raspberry pi 5
    ];

  };

}
