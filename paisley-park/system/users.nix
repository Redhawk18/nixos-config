{ pkgs, ... }: {
  users = {
    groups = { minecraft = { }; };
    users = {

      redhawk = {
        isNormalUser = true;
        description = "Redhawk";
        extraGroups =
          [ "docker" "minecraft" "networkmanager" "systemd-journal" "wheel" ];
        packages = with pkgs; [ firefox vscodium ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfTvGUneRjHy8UxRmxuxZdNjiiJuhbor5yDfWDUZyrG redhawk@Malos"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVfQmsyWF3enfOUtx/MtltC9Lq1ia9y6/Cfpr8q+nR1 redhawk@Mythra"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNeg9WrL8grTL2y7VIrV4BvgNoGn9+ofgTcip1nC7nH redhawk@Pyra"
        ];
      };

      minecraft = {
        isSystemUser = true;
        group = "minecraft";
      };
    };
  };
}
