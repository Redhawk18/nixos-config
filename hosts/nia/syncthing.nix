{

  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    settings = {
      devices = {
        "Mythra" = {
          id = "UEN335T-27HR62N-ULJMQCF-XKQ26ZS-EAK4CCY-STSSXTK-S65PO63-5SIEWAC";
        };
      };

      gui = {
        user = "redhawk";
        password = "password";
      };

      folders = {
        "school" = {
          path = "/home/redhawk/Desktop/school/";
          devices = [
            "Mythra"
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
  };

  networking.firewall = {
    allowedTCPPorts = [ 8384 ];
  };
}
