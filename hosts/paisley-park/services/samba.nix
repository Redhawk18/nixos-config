{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      shares = {
        server_files = {
          browseable = "yes";
          comment = "Server Files";
          path = "/boundman/server_files/";
          "read only" = "no";
        };
      };
    };
    samba-wsdd = { enable = true; };
  };
}
