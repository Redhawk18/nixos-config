{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    docker
    docker-compose
    git
    home-manager
    neovim
    wget
  ];
}
