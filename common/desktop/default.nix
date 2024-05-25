{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 6 Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.akonadi
    kdePackages.filelight
    kdePackages.kdepim-runtime
    kdePackages.kdeconnect-kde
    kdePackages.kmail
    kdePackages.kmail-account-wizard
    kdePackages.kolourpaint
    kdePackages.korganizer
    kdePackages.okular
    kdePackages.skanpage

    audacious
    firefox

    monero-gui
    libreoffice-qt
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    noto-fonts
    plex-media-player
    plexamp
    vesktop
  ];

  programs = {
    dconf.enable = true;

    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
      };
    };
  };
}
