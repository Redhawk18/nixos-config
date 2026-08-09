# NixOS module for torrent-cleaner.
#
# Self-contained: the default package is the derivation in ./default.nix, so
# importing this module alone is enough — no overlay required. Import it from a
# host, e.g.:
#   imports = [ ../../pkgs/torrent-cleaner/module.nix ];
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.torrent-cleaner;

  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;

  # The app reads its configuration straight from environment variables, so a
  # Nix value has to be rendered the way the app expects (booleans as
  # "true"/"false", numbers as their decimal string).
  toEnvValue =
    v:
    if lib.isBool v then
      (if v then "true" else "false")
    else
      toString v;

  # Sensible defaults, overridable via `settings`. DRY_RUN defaults to true so a
  # fresh deployment never deletes anything until explicitly opted in.
  defaultSettings = {
    DATA_DIR = "/var/lib/torrent-cleaner";
    DRY_RUN = true;
  };

  finalSettings = defaultSettings // cfg.settings;
  environment = lib.mapAttrs (_name: toEnvValue) finalSettings;
in
{
  options.services.torrent-cleaner = {
    enable = mkEnableOption "torrent-cleaner, the qBittorrent seeding cleaner";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ./default.nix { };
      defaultText = lib.literalExpression "pkgs.callPackage ./default.nix { }";
      description = "The torrent-cleaner package to run.";
    };

    user = mkOption {
      type = types.str;
      default = "root";
      description = ''
        User to run torrent-cleaner as. Must be able to read the torrent and
        media directories and, when FIX_HARDLINKS is enabled, write to the
        torrent directory. Defaults to root to match a root-run qBittorrent.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "root";
      description = "Group to run torrent-cleaner as.";
    };

    schedule = mkOption {
      type = types.str;
      default = "*-*-* 02:00:00";
      example = "daily";
      description = ''
        When to run, as a systemd `OnCalendar` expression. Defaults to 02:00
        every day.
      '';
    };

    environmentFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      example = "/etc/torrent-cleaner/secrets.env";
      description = ''
        Path to an environment file (KEY=value lines) loaded into the service,
        suitable for secrets so they are not written to the Nix store. Use it
        for {env}`QBITTORRENT_PASSWORD` and, if set, {env}`DISCORD_WEBHOOK_URL`.
      '';
    };

    settings = mkOption {
      type = types.attrsOf (types.oneOf [
        types.str
        types.int
        types.bool
      ]);
      default = { };
      example = lib.literalExpression ''
        {
          QBITTORRENT_HOST = "localhost";
          QBITTORRENT_PORT = 8081;
          QBITTORRENT_USERNAME = "admin";
          TORRENT_DIR = "/boundman/qbittorrent";
          MEDIA_LIBRARY_DIR = "/boundman/server_files";
          DELETION_CRITERIA = "30d 2.0";
          DRY_RUN = true;
          FIX_HARDLINKS = true;
          HARDLINK_BYTE_VERIFY = true;
          MAX_DELETIONS_PER_RUN = 10;
        }
      '';
      description = ''
        Configuration passed to torrent-cleaner as environment variables. Keys
        are the variable names from the project's `.env.example`. Booleans are
        rendered as `true`/`false` and integers as decimal strings.

        Do not put secrets here (they would land in the world-readable Nix
        store) — use {option}`services.torrent-cleaner.environmentFile` instead.

        `DATA_DIR` defaults to `/var/lib/torrent-cleaner` and `DRY_RUN` defaults
        to `true`.
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.torrent-cleaner = {
      description = "torrent-cleaner (qBittorrent seeding cleaner)";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      inherit environment;

      serviceConfig = {
        Type = "oneshot";
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${finalSettings.DATA_DIR}/cache ${finalSettings.DATA_DIR}/logs";
        ExecStart = lib.getExe cfg.package;
        User = cfg.user;
        Group = cfg.group;
        EnvironmentFile = mkIf (cfg.environmentFile != null) cfg.environmentFile;
        StateDirectory = "torrent-cleaner";
      };
    };

    systemd.timers.torrent-cleaner = {
      description = "Schedule torrent-cleaner";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = cfg.schedule;
        Persistent = true;
      };
    };
  };
}
