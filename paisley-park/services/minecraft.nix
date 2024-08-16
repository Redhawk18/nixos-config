{ lib, pkgs, ... }:
let
  MinecraftVanilla = { name, memory }: {
    "minecraft-${name}" = {
      enable = true;
      unitConfig = {
        Description = "${name} minecraft server";
        Wants = "network-online.target";
        After = "network-online.target";
      };

      serviceConfig = {
        User = "minecraft";
        Group = "minecraft";
        StateDirectory = "minecraft/${name}";
        StateDirectoryMode = "0775";
        WorkingDirectory = "%S/minecraft/${name}";
        ExecStart =
          "${pkgs.jdk17}/bin/java -Xmx${memory}G -Xms1G -jar server.jar";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
  # For modded worlds or anything that isn't run with the normal server command.
  MinecraftCustom = { name, cmd }: {
    "minecraft-${name}" = {
      enable = true;
      unitConfig = {
        Description = "${name} minecraft server";
        Wants = "network-online.target";
        After = "network-online.target";
      };

      serviceConfig = {
        User = "minecraft";
        Group = "minecraft";
        StateDirectory = "minecraft/${name}";
        StateDirectoryMode = "0775";
        WorkingDirectory = "%S/minecraft/${name}";
        ExecStart = cmd;
      };

      path = with pkgs; [ bash jdk17 ];


      wantedBy = [ "multi-user.target" ];
    };
  };
in
{
  #  systemd.services = lib.attrsets.mergeAttrsList [
  #    (MinecraftVanilla {
  #      name = "1.20-World";
  #      memory = "4";
  #    })
  #  ];

  systemd.services = lib.attrsets.mergeAttrsList [
    (MinecraftCustom {
      name = "atm9";
      cmd = "/var/lib/minecraft/atm9/run.sh";
    })
  ];

}
