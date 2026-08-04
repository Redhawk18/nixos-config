{ ... }: {
  services.cross-seed = {
    enable = true;
    user = "root";
    group = "root";
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
}
