{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
        shares = {
          browseable = true;
          comment = "Sophia's Network Share";
          path = "/var/share";
          "read only" = false;
        };

    };
    samba-wsdd = { enable = true; };
  };
}
