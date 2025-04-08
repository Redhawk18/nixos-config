{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    btop
    busybox
    docker
    docker-compose
    fd
    git
    home-manager
    neovim
    screen
    wget
  ];

}
