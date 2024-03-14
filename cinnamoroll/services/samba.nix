{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
        shares = {
          browseable = "yes";
          comment = "Sophia's Network Share";
          path = "/var/share";
          "read only" = "no";
        };

    };
    samba-wsdd = { enable = true; };
  };
}
