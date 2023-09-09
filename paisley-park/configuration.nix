# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "Paisley-Park"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  users.users.redhawk = {
    isNormalUser = true;
    description = "Redhawk";
    extraGroups = [ "docker" "networkmanager" "systemd-journal" "wheel" ];
    packages = with pkgs; [
      firefox
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfTvGUneRjHy8UxRmxuxZdNjiiJuhbor5yDfWDUZyrG redhawk@Malos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVfQmsyWF3enfOUtx/MtltC9Lq1ia9y6/Cfpr8q+nR1 redhawk@Mythra"
    ];
  };
  home-manager.users.redhawk = { config, pkgs, ... }: {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.05";
    # Let Home Manager install and manage itself.
    programs = {
      home-manager.enable = true;

      bash = {
        enable = true;

        initExtra = ''
          PS1="\n\e[1;31m─\u\e[1m🎉\e[1;95m\h\e[1m─ \e[1;34m\w\e[0m \n \e[1;31m└\$ \e[0m"
          PS2="=>"
        '';

        sessionVariables = {
          # Rust
          RUST_LOG = "info";
        };

        shellAliases = {
          ".." = "cd ..";
          ll = "ls -lah";
          shutdown = "loginctl poweroff";
          switch = "sudo nixos-rebuild switch";
          update = "sudo nix-channel --update && sudo nixos-rebuild switch";
          reboot = "loginctl reboot";
        };
      };

      git = {
        enable = true;
        userName  = "Redhawk18";
        userEmail = "redhawk76767676@gmail.com";
      };

      ssh = {
        enable = true;
        compression = true;

        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/home/redhawk/.ssh/keys/github";
          };
        };
      };
    };
  };

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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  boot = {
    supportedFilesystems = [ "zfs" ];

    zfs = {
      forceImportRoot = false;
      extraPools = [ "boundman" ];
    };
  };
  programs = {
    ssh.forwardX11 = true;
  };
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
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      openDefaultPorts = true;

      devices = {
      "Mythra" = { id = "Y4KJM7K-J6HPIBA-4PGRSRY-2ULLEOQ-VRHFAJP-VJNZTYQ-Z7BVOES-L5E4ZAK"; };
      "steamdeck" = { id = "3HLGLKX-DDVZOQR-TDALFVX-LDPR7E7-3WOQT3F-XKQCCDX-W2RBFBK-XLK4CQT"; };
      };            
      
      extraOptions. gui = {
        user = "redhawk";
        password = "password";
      };

      folders = {
        "dolphin" = {
          path = "~/dolphin";
          devices = [ "Mythra" "steamdeck" ];
          rescanInterval = 60;
          versioning = {
            type = "simple";
            params = {
              keep = "3";
              cleanoutDays = "14";
            };
          };

        };

        "yuzu" = {
          path = "~/yuzu";
          devices = [ "Mythra" "steamdeck" ];
          rescanInterval = 60;
          versioning = {
            type = "simple";
            params = {
              keep = "3";
              cleanoutDays = "14";
            };
          };
        };
      };

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
        ExecStart= "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8081";
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

  networking = {
    hostId = "0bb9c30d";

    firewall = {
      enable = false;

      # Open ports in the firewall.
      # nfs.server https://nixos.wiki/wiki/NFS
      # syncthing https://nixos.wiki/wiki/Syncthing
      # allowedTCPPorts = [ ];
      # allowedUDPPorts = [ ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
