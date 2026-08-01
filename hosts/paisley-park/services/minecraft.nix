{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/var/lib/minecraft/";

    servers = {
      "1.21-World" = {
        enable = false;
        package = pkgs.minecraftServers.vanilla-1_21_4;
        jvmOpts = "-Xms1G -Xmx8G";

        serverProperties = {
          difficulty = "hard";
          enforce-whitelist = true;
          level-name = "1.21-World";
          level-seed = 7025192174381717753;
          motd = "A thankful server";
          server-ip = "paisley-park";
          server-port = 25565;
          simulation-distance = 18;
          spawn-protection = 0;
          view-distance = 16;
          white-list = true;
        };
      };

      big-chad-guys-2 = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_20_1;
        jvmOpts = "-Xms2G -Xmx16G";

        serverProperties = {
          allowFlight = true;
          difficulty = "hard";
          enforce-whitelist = true;
          level-name = "bigChadGuys2";
          motd = "A Strawberryrkc Summer";
          pvp = false;
          server-ip = "paisley-park";
          server-port = 25566;
          simulation-distance = 14;
          spawn-protection = 0;
          view-distance = 12;
          white-list = true;
        };

        symlinks =
          let
            modpack = pkgs.fetchzip {
              url = "https://mediafilez.forgecdn.net/files/5710/212/BCG%2B%20NC%202.7.1%20Server%20Files.zip";
              hash = "sha256-qIw02IU2kOCINEsQqAAwKXrCJmeoxQtxFNcYif4bm3Y=";
              stripRoot = false;
            };
          in
          {
            "mods" = "${modpack}/mods";
          };
      };

      coop = {
        enable = true;
        package = pkgs.fabricServers.fabric-26_2.override { jre_headless = pkgs.jdk25; };
        jvmOpts = "-Xms1G -Xmx8G";

        serverProperties = {
          difficulty = "hard";
          enforce-whitelist = true;
          level-name = "coop";
          level-seed = -8673088829358497132;
          motd = "Our Co op <3";
          server-port = 25567;
          simulation-distance = 18;
          spawn-protection = 0;
          view-distance = 16;
          white-list = true;
        };

        symlinks = {
          "mods/voicechat-fabric-2.6.21+26.2.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/3SOh5iiX/voicechat-fabric-2.6.21%2B26.2.jar";
            hash = "sha256-7V+hoRf6Jr+8hGPCf4io3/xT2id3gfJm7RESKB9/Zfc=";
          };
          "mods/DistantHorizons-3.2.0-b-26.2-fabric-neoforge.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uCdwusMi/versions/gBf0SaV1/DistantHorizons-3.2.0-b-26.2-fabric-neoforge.jar";
            hash = "sha256-+3pg+gZ3XSCP9HzkuYxmjNxSdEnDfaSoBoaVeURWNJ8=";
          };
        };
      };

    };
  };

  environment.systemPackages = with pkgs; [
    tmux
  ];
}
