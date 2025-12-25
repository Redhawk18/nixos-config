{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    attic-client
    btop
    busybox
    devenv
    docker
    docker-compose
    fd
    git
    gh
    home-manager
    neovim
    screen
    smartmontools
    wget
  ];

}
