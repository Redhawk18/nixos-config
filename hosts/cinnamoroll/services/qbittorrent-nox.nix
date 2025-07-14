{ pkgs, ... }: {
  systemd.services.qbittorrent-nox = {
    enable = true;
    unitConfig = {
      Description = "qBittorrent-nox service";
      Documentation = "man:qbittorrent-nox(1)";
      Wants = "network-online.target";
      After = "network-online.target nss-lookup.target";
    };

    serviceConfig = {
      Type = "exec";
      ExecStart =
        "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8081";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
