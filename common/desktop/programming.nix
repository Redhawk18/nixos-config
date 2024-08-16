{ config, lib, pkgs, ... }:
{
  options = {
    programming.enable = lib.mkEnableOption "enables programming";
  };

  config = lib.mkIf config.programming.enable {

    environment.systemPackages = with pkgs; [
      distrobox
      docker
      docker-compose
      jetbrains.idea-ultimate
      jdk17
    ];
  };
}
