{
    services.syncthing = {
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
}