{ config, lib, pkgs, ... }:
{

  config = lib.mkIf config.desktop.programming {
    environment.systemPackages = with pkgs; [
      vscode
      distrobox
      jetbrains.idea-ultimate
      insomnia
    ];
  };
}
