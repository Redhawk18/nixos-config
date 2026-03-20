{
  config,
  lib,
  nixpkgs,
  pkgs,
  unstable,
  ...
}:
{

  config = lib.mkIf config.desktop.gaming {
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [ fuse ];
      gamescopeSession.enable = true;

      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      # glfw # prismlauncher
      glfw3-minecraft

      unstable.edopro
      unstable.gale
      unstable.r2modman
      # lutris
      unstable.prismlauncher
      unstable.ryubing

    ];

    syncthing = lib.mkDefault true;
  };
}
