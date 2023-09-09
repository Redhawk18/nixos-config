{
  networking = {
    hostId = "0bb9c30d";
    hostName = "Paisley-Park";

    firewall = {
      enable = false;

      # Open ports in the firewall.
      # nfs.server https://nixos.wiki/wiki/NFS
      # syncthing https://nixos.wiki/wiki/Syncthing
      # allowedTCPPorts = [ ];
      # allowedUDPPorts = [ ];
    };

    networkmanager.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;
  };
}