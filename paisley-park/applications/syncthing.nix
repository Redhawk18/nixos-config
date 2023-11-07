{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    devices = {
      "Mythra" = {
        id = "VN4QWFB-PWQNLPM-75CJOFR-J5MOP42-GZCRU23-VHJAUU5-ZDXX6RL-QFSCKAO";
      };
      "steamdeck" = {
        id = "3HLGLKX-DDVZOQR-TDALFVX-LDPR7E7-3WOQT3F-XKQCCDX-W2RBFBK-XLK4CQT";
      };
    };

    extraOptions.gui = {
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

      "unrailed" = {
        path = "~/unrailed";
        devices = [ "Mythra" "steamdeck" ];
        rescanInterval = 180;
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
  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
	allowedUDPPorts = [ 22000 21027 ];
  }
}
