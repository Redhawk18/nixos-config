{ ... }: {
  services.qbittorrent = {
    enable = true;

    # Runs as the `qbittorrent` user in the shared `media` group so files it
    # downloads stay readable/writable to sonarr/radarr/lidarr/cross-seed for
    # hardlinking and atomic moves. See system/media-storage.nix.
    user = "qbittorrent";
    group = "media";

    webuiPort = 8081;

    # qbittorrent-nox refuses to start headless until the legal notice is
    # accepted; without this it exits 0 immediately under systemd.
    extraArgs = [ "--confirm-legal-notice" ];
  };

  # umask 0002 so downloaded files land group-writable (664/775) for the arrs.
  systemd.services.qbittorrent.serviceConfig.UMask = "0002";
}
