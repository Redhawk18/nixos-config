{ config, lib, pkgs, ... }:
{

  config = lib.mkIf config.desktop.programming {
    environment.systemPackages = with pkgs; [
      distrobox
      jetbrains.idea-ultimate
    ];
  };
}
