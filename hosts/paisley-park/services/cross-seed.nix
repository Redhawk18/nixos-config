{ ... }: {
  services.cross-seed = {
    enable = true;
    # Runs as `cross-seed` in the shared `media` group so it can read the
    # qbittorrent data dir and hardlink into linkDirs. See media-storage.nix.
    group = "media";
    settings = {
      action = "inject";
      dataDirs = [ "/boundman/qbittorrent" ];
      linkDirs = [ "/boundman/cross-seed-links" ];
      linkType = "hardlink";
      matchMode = "flexible";
      outputDir = null;
      port = 2468;
      searchCadence = "1 day";
      excludeRecentSearch = "3 days";
      excludeOlder = "2 weeks";
      torrentClients = [
        "qbittorrent:http://admin:adminadmin@localhost:8081"
      ];
      torznab = [
        "http://localhost:9696/1/api?apikey=20a94ff4aba24e37b41a30e4f073e04c" # TorrentLeech
        "http://localhost:9696/4/api?apikey=20a94ff4aba24e37b41a30e4f073e04c" # AnimeBytes
      ];
    };
  };

  # group-writable hardlinks so seeding stays accessible to the arrs.
  systemd.services.cross-seed.serviceConfig.UMask = "0002";
}
