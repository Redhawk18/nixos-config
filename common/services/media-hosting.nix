{
  config,
  lib,
  unstable,
  ...
}:
let
  cfg = config.services.media-hosting;
  torrentDir = "${cfg.storageBase}/qbittorrent";
  crossSeedDir = "${cfg.storageBase}/cross-seed-links";
  libraryDir = if cfg.libraryDir != null then cfg.libraryDir else "${cfg.storageBase}/server_files";
in
{
  imports = [ ../../pkgs/torrent-cleaner/module.nix ];

  options.services.media-hosting = {
    enable = lib.mkEnableOption "arr media stack (plex + sonarr/radarr/lidarr + prowlarr + flaresolverr + qbittorrent + cross-seed + torrent-cleaner)";

    storageBase = lib.mkOption {
      type = lib.types.str;
      example = "/share";
      description = "Base filesystem path for all media storage. Everything must be on one filesystem to allow hardlinks between the download dir and the library.";
    };

    libraryDir = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/share";
      description = "Root of the Plex/arr media library. Defaults to <storageBase>/server_files.";
    };

  };

  config = lib.mkIf cfg.enable {
    users.groups.media = { gid = 987; };

    users.users = {
      plex.extraGroups = [ "media" ];
      torrent-cleaner = {
        isSystemUser = true;
        group = "media";
        description = "torrent-cleaner service user";
      };
    };

    systemd.tmpfiles.rules = [
      "d ${torrentDir}   2775 qbittorrent media -"
      "d ${crossSeedDir} 2775 cross-seed  media -"
    ];

    services.flaresolverr = {
      enable = true;
      openFirewall = true;
    };

    services.plex = {
      enable = true;
      openFirewall = true;
    };

    services.prowlarr = {
      enable = true;
      openFirewall = true;
      package = unstable.prowlarr;
    };

    services.lidarr = {
      enable = true;
      openFirewall = true;
      package = unstable.lidarr;
      group = "media";
    };
    systemd.services.lidarr.serviceConfig.UMask = lib.mkForce "0002";

    services.radarr = {
      enable = true;
      openFirewall = true;
      package = unstable.radarr;
      group = "media";
    };
    systemd.services.radarr.serviceConfig.UMask = lib.mkForce "0002";

    nixpkgs.config.permittedInsecurePackages = [
      "aspnetcore-runtime-6.0.36"
      "aspnetcore-runtime-wrapped-6.0.36"
      "dotnet-sdk-6.0.428"
      "dotnet-sdk-wrapped-6.0.428"
    ];
    services.sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    systemd.services.sonarr.serviceConfig.UMask = lib.mkForce "0002";

    services.qbittorrent = {
      enable = true;
      user = "qbittorrent";
      group = "media";
      webuiPort = 8081;
      extraArgs = [ "--confirm-legal-notice" ];
    };
    systemd.services.qbittorrent.serviceConfig.UMask = "0002";

    services.cross-seed = {
      enable = true;
      group = "media";
      settings = {
        action = "inject";
        dataDirs = [ torrentDir ];
        linkDirs = [ crossSeedDir ];
        linkType = "hardlink";
        matchMode = "flexible";
        outputDir = null;
        port = 2468;
        searchCadence = "1 day";
        excludeRecentSearch = "3 days";
        excludeOlder = "2 weeks";
        torrentClients = [ "qbittorrent:http://admin:adminadmin@localhost:8081" ];
      };
    };
    systemd.services.cross-seed.serviceConfig.UMask = "0002";

    services.torrent-cleaner = {
      enable = true;
      user = "torrent-cleaner";
      group = "media";
      settings = {
        QBITTORRENT_HOST = "localhost";
        QBITTORRENT_PORT = 8081;
        QBITTORRENT_USERNAME = "admin";
        QBITTORRENT_PASSWORD = "adminadmin";
        TORRENT_DIR = torrentDir;
        MEDIA_LIBRARY_DIR = libraryDir;
        DELETION_CRITERIA = "100d 2.0";
        DRY_RUN = false;
        MAX_DELETIONS_PER_RUN = 0;
        FIX_HARDLINKS = true;
        ALLOW_EMPTY_MEDIA_LIBRARY = false;
        LOG_LEVEL = "INFO";
        TZ = "America/New_York";
      };
    };
  };
}
