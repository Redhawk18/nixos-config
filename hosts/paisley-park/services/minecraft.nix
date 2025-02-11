{ inputs, pkgs, ... }:
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
        enable = true;
        package = pkgs.minecraftServers.vanilla-1_21_4;
        jvmOpts = "-Xms1G -Xmx8G";

        serverProperties = {
          difficulty = "hard";
          enforce-whitelist = true;
          level-name = "1.21-World";
          level-seed = 7025192174381717753;
          motd = "A thankful server";
          server-ip = "paisley-park.lan";
          server-port = 25565;
          simulation-distance = 18;
          spawn-protection = 0;
          view-distance = 16;
          white-list = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tmux
  ];
}
