{ pkgs, ... }:
{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # (lutris.override { extraLibraries = pkgs: [ ]; })
    prismlauncher
    r2modman
    syncthingtray
    vesktop
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    settings.devices = {
      "Paisley-Park" = {
        id = "HYS7CC6-I4BKAQL-ZIZL23L-LQR5PK6-OJ2HGVW-HQU64QD-UQQLDTQ-JXPZSAG";
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
