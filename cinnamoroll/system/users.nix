{ pkgs, ... }: {
  users = {
    users = {

      redhawk = {
        isNormalUser = true;
        description = "Redhawk";
        extraGroups =
          [ "networkmanager" "systemd-journal" "wheel" ];
        packages = with pkgs; [ neovim ];

        openssh.authorizedKeys.keys = [];
      };

	  soph = {
		isNormalUser = true;
		description = "Sophia";
		extraGroups = [ "networkmanager" "systemd-journal" "wheel" ];
		packages = with pkgs; [  ];
		openssh.authorizedKeys.keys = [  ];
	  };

    };
  };
}
