{

  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    devices = {
      "Mythra" = {
        id = "UEN335T-27HR62N-ULJMQCF-XKQ26ZS-EAK4CCY-STSSXTK-S65PO63-5SIEWAC";
      };
      "PopTart" = {
        id = "ETGPVEU-O6Q4DXM-3RLBTAD-O2JY5EA-NLMM33J-5DEOQFE-6SH7KMT-FZQFNA7";
      };
    };

    extraOptions.gui = {
      user = "redhawk";
      password = "password";
    };

    folders = {
      "school" = {
        path = "/home/redhawk/Desktop/school/";
        devices = [
          "Mythra"
          "PopTart"
        ];
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

  networking.firewall = {
    allowedTCPPorts = [ 8384 ];
  };
}
