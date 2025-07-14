{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    devices = {
      "laptop" = {
        id = "GMRVMY4-GJOJN72-ANV4LJ4-XUPPWI2-Y7EUKTF-FBK4GPQ-ESV24LZ-SXXMOAP";
      };
      "phone" = {
        id = "QOLXN55-6RAIXGK-KTVILCP-CGSBOJX-MHY4QUM-YJKNXSU-CWG7GQ3-AYRFPAM";
      };
    };

    folders = {
      "documents" = {
        path = "~/documents";
        devices = [ "laptop" "phone" ];
        versioning = {
          type = "simple";
          params = {
            keep = "3";
            cleanoutDays = "14";
          };
        };

      };
    };

    folders = {
      "important" = {
        path = "~/important";
        devices = [ "laptop" "phone" ];
        versioning = {
          type = "simple";
          params = {
            keep = "5";
            cleanoutDays = "90";
          };
        };

      };
    };

    folders = {
      "pictures" = {
        path = "~/pictures";
        devices = [ "laptop" "phone" ];
        versioning = {
          type = "simple";
          params = {
            keep = "3";
            cleanoutDays = "60";
          };
        };

      };

    };
  };

  networking.firewall = { allowedTCPPorts = [ 8384 ]; };
}
