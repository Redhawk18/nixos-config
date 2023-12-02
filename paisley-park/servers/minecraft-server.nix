{ pkgs, ... }: {
  systemd.services.sophie = {
    enable = false;
    unitConfig = {
      Description = "Sophie's minecraft server";
      Wants = "network-online.target";
      After = "network-online.target";
    };

    serviceConfig = {
      User = "redhawk";
      WorkingDirectory = "/home/redhawk/minecraft/sophie/";
      ExecStart = "${pkgs.jre}/bin/java -jar server.jar";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
