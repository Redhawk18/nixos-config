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
          # "force user" = "nobody";
          # "create mask" = "0644";
          # "directory mask" = "0755";
		};
      };
    };
    samba-wsdd = {
      enable = true;
    };
  };
}
