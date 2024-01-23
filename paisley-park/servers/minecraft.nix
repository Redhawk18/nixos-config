{ lib, pkgs, ... }:
let
  Minecraft = { name, memory }: {
    "minecraft-${name}" = {
      enable = true;
      unitConfig = {
        Description = "${name}'s minecraft server";
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
          "${pkgs.jre}/bin/java -Xmx${memory}G -Xms1G -jar server.jar";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
in {
  systemd.services = lib.attrsets.mergeAttrsList [
    (Minecraft {
    #  name = "sophie";
    #  memory = "2";
    # }
    # Minecraft {
      name = "1.19-World";
      memory = "4";
    })
  ];
}
