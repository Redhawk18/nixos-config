{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    devices = {
      "Mythra" = {
        id = "UEN335T-27HR62N-ULJMQCF-XKQ26ZS-EAK4CCY-STSSXTK-S65PO63-5SIEWAC";
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
      # https://github.com/Ryujinx/Ryujinx/issues/3975#issuecomment-2002290391
      "ryujinx" = {
        path = "~/ryujinx";
        devices = [ "Mythra" "steamdeck" ];
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
        # devices = [ "Mythra" "steamdeck" ];
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
