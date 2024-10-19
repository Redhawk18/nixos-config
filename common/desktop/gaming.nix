{ config, lib, pkgs, ... }:
let
  user = "redhawk";
in
{
  config = lib.mkIf config.desktop.gaming {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      # (lutris.override { extraLibraries = pkgs: [ ]; })
      appimage-run
      fuse
      prismlauncher
      r2modman
      ryujinx
      vesktop
    ];

    services.syncthing = {
      enable = true;
      openDefaultPorts = true; # TCP/UDP 22000 UDP 21027
      overrideFolders = false;

      user = "${user}";
      dataDir = "/home/${user}";
      configDir = "/home/${user}/.config";

      settings.devices."Paisley-Park".id = "HYS7CC6-I4BKAQL-ZIZL23L-LQR5PK6-OJ2HGVW-HQU64QD-UQQLDTQ-JXPZSAG";
    };

    networking.firewall = {
      allowedTCPPorts = [ 8384 ];
    };
  };
}
