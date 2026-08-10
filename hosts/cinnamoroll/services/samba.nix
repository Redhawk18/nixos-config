{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      shares = {
        server_files = {
          browseable = "yes";
          comment = "Server Files";
          path = "/mnt/media";
          "read only" = "no";
        };
      };
    };
    samba-wsdd = { enable = true; };
  };
}
