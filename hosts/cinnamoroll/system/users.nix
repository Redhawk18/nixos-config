{ pkgs, ... }: {
  users = {
    users = {
      redhawk = {
        isNormalUser = true;
        description = "Redhawk";
        extraGroups = [ "networkmanager" "systemd-journal" "wheel" ];
        packages = with pkgs; [ btop starship neovim ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAiaWtEJpYB64AColYcZCUwkAQ1TYvUdURJYVngT9MQ redhawk@Mythra"
        ];
      };
    };
  };
}
