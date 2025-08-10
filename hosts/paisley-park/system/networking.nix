{
  networking = {
    hostId = "0bb9c30d";
    hostName = "Paisley-Park";

    firewall = {
      enable = false;
      # Open ports in the firewall.
      # allowedTCPPorts = [ ];
      # allowedUDPPorts = [ ];
    };

    # networkmanager.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;

    wireless.iwd = {
      enable = true;

      settings = {
        Rank = {
          BandModifier2_4GHz = 1;
          BandModifier5GHz = 2;
        };
        Settings = {
          AutoConnect = true;
        };

      };
    };

  };
}
