{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    btop
    busybox
    docker
    docker-compose
    fd
    git
    gh
    home-manager
    neovim
    screen
    wget
  ];

}
