{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;

    devices = {
      "laptop".id = "AJIOG4H-TX5MIHI-QGZ7PQQ-XDJMO6C-VIB4PXH-UOOZK57-CMMACYG-4TXH3AI";
      "phone".id = "QOLXN55-6RAIXGK-KTVILCP-CGSBOJX-MHY4QUM-YJKNXSU-CWG7GQ3-AYRFPAM";
      "Poptart".id = "ETGPVEU-O6Q4DXM-3RLBTAD-O2JY5EA-NLMM33J-5DEOQFE-6SH7KMT-FZQFNA7";
      "Toast-em".id = "YGWIEGD-WFUCIX7-CK4TOH5-TRE4BND-IEIDVRX-F7XRFG2-EAEIZMC-DYNFZQV";
    };

    folders = {
      "documents" = {
        path = "~/documents";
        devices = [
          "laptop"
          "phone"
          "Poptart"
          "Toast-em"
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

    folders = {
      "important" = {
        devices = [
          "laptop"
          "phone"
          "Poptart"
          "Toast-em"
        ];
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
        devices = [
          "laptop"
          "phone"
          "Poptart"
          "Toast-em"
        ];
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

  networking.firewall = {
    allowedTCPPorts = [ 8384 ];
  };
}
