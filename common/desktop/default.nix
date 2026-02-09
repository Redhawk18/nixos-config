{
  config,
  lib,
  pkgs,
  pure,
  unstable,
  ...
}:
{
  imports = [
    ./gaming.nix
    ./programming.nix
  ];

  options = {
    desktop = {
      enable = lib.mkEnableOption "enables desktop";
      gaming = lib.mkEnableOption "enable desktop gaming";
      programming = lib.mkEnableOption "enable desktop programming";
    };
  };

  config = lib.mkIf config.desktop.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Plasma 6 Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [ elisa ];

    environment.systemPackages = with pkgs; [
      kdePackages.akonadi
      kdePackages.filelight
      kdePackages.kdepim-runtime
      kdePackages.kolourpaint
      kdePackages.korganizer
      kdePackages.okular
      kdePackages.skanpage
      kdePackages.yakuake

      audacious
      firefox
      monero-gui
      libreoffice
      obs-studio
      plexamp
      puddletag
      qbittorrent
      vesktop
      discord
      slack
      vlc
    ];

    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.symbols-only
        noto-fonts
      ];
    };

    programs = {
      appimage = {
        enable = true;
        binfmt = true;
      };
      dconf.enable = true;

      firefox = {
        enable = true;
        preferences = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
        };
      };

      kdeconnect.enable = true;
    };

    services.flatpak.enable = true;

  };
}
