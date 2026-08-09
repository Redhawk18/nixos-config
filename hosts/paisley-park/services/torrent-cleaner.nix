{ ... }:
# Replaces the ~/docker/torrent-cleaner container. Settings mirror that .env.
# The qBittorrent password is the default admin:adminadmin (already in plaintext
# in cross-seed.nix), so it's inlined rather than kept in an environmentFile.
{
  imports = [ ../../../pkgs/torrent-cleaner/module.nix ];

  # Unprivileged user in the shared media group; the module doesn't create it.
  users.users.torrent-cleaner = {
    isSystemUser = true;
    group = "media";
    description = "torrent-cleaner service user";
  };

  services.torrent-cleaner = {
    enable = true;

    # Dedicated unprivileged user in the shared media group (same scheme as the
    # other media services); can read the library and read/write the download
    # dir for FIX_HARDLINKS via group perms.
    user = "torrent-cleaner";
    group = "media";

    # CRON_SCHEDULE "0 2 * * *" from the .env == the module's default 02:00 daily.

    settings = {
      QBITTORRENT_HOST = "localhost";
      QBITTORRENT_PORT = 8081;
      QBITTORRENT_USERNAME = "admin";
      QBITTORRENT_PASSWORD = "adminadmin";

      TORRENT_DIR = "/boundman/qbittorrent";
      MEDIA_LIBRARY_DIR = "/boundman/server_files";

      # Delete torrents seeding >= 100 days AND ratio >= 2.0. Torrents still
      # hardlinked into the media library are protected automatically.
      DELETION_CRITERIA = "100d 2.0";

      # Matches the docker container: real deletions, no per-run cap.
      DRY_RUN = false;
      MAX_DELETIONS_PER_RUN = 0; # 0 = unlimited
      FIX_HARDLINKS = true;
      ALLOW_EMPTY_MEDIA_LIBRARY = false;

      LOG_LEVEL = "INFO";
      TZ = "America/New_York";
    };
  };
}
