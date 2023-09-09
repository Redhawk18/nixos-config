# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (fetchTarball
      "https://github.com/nix-community/nixos-vscode-server/tarball/master")


    ./hosting/syncthing.nix

    ./system/boot.nix
    ./system/home-manager.nix
    ./system/networking.nix
    ./system/users.nix
  ];

  services.vscode-server.enable = true;
  #services.vscode-server.installPath = "~/.vscodium-server";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    adguardhome
    cmake
    docker
    docker-compose
    git
    gcc
    gnumake
    htop
    inxi
    neofetch
    nfs-utils
    openssh
    plex
    qbittorrent-nox
    syncthing
    wget
    zfs
    nixfmt
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
    };
    nfs.server = {
      enable = true;
      exports = ''
        /boundman/server_files *(rw,sync)
      '';
    };
    openssh.enable = true;
    plex = {
      enable = true;
      openFirewall = true;
    };

    zfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
  };
  systemd = {
    services.qbittorrent-nox = {
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
        User = "redhawk";
      };

      wantedBy = [ "multi-user.target" ];
    };
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };
  virtualisation.docker.enable = true;

  system.stateVersion = "23.05";
}
