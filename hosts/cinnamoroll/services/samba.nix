{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      shares = {
        server_files = {
          browseable = "yes";
          comment = "Server Files";
          path = "/share";
          "read only" = "no";
        };
      };
    };
    samba-wsdd = { enable = true; };
  };
}
