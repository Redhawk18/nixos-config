{
  config,
  lib,
  nixpkgs,
  pkgs,
  unstable,
  ...
}:
let
  user = "redhawk";
in
{

  config = lib.mkIf config.desktop.gaming {
    nixpkgs.overlays = [
      (final: prev: {
        prismlauncher =
          (prev.prismlauncher-unwrapped.override {
          }).overrideAttrs
            (oldAttrs: {
              version = "unstable-2025-10-19";
              src = final.fetchFromGitHub {
                owner = "redhawk18";
                repo = "PrismLauncher";
                rev = "8e42b8ec97f37774aa28510ebea9b4a5f85460f9";
                sha256 = "sha256-YtAI5VNSS+CM2REoeHiU8zjUVRXt3OkbJ2dUm6jNMIM=";
              };
              patches = [ ];

              postUnpack =
                let
                  qrcodegenerator = final.fetchFromGitHub {
                    owner = "nayuki";
                    repo = "QR-Code-generator";
                    rev = "2c9044de6b049ca25cb3cd1649ed7e27aa055138";
                    sha256 = "sha256-6SugPt0lp1Gz7nV23FLmsmpfzgFItkSw7jpGftsDPWc=";
                  };
                in
                oldAttrs.postUnpack
                + ''
                  rm -rf source/libraries/qrcodegenerator
                  ln -s ${qrcodegenerator} source/libraries/qrcodegenerator
                '';
            });
      })
    ];

    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [ fuse ];
      gamescopeSession.enable = true;

      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      unstable.edopro
      unstable.gale
      unstable.r2modman
      # lutris
      prismlauncher
      unstable.ryubing

    ];

    services.syncthing = {
      enable = true;
      openDefaultPorts = true; # TCP/UDP 22000 UDP 21027
      overrideFolders = false;

      user = "${user}";
      dataDir = "/home/${user}";
      configDir = "/home/${user}/.config";

      settings.devices."Paisley-Park".id =
        "HYS7CC6-I4BKAQL-ZIZL23L-LQR5PK6-OJ2HGVW-HQU64QD-UQQLDTQ-JXPZSAG";
    };

    networking.firewall = {
      allowedTCPPorts = [ 8384 ];
    };
  };
}
