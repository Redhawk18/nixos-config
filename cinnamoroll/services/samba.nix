{
  services = {
    samba = {
      enable = true;
      openFirewall = true;

      shares = {};
    };
    samba-wsdd = { enable = true; };
  };
}
