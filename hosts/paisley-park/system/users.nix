{ pkgs, ... }: {
  users = {
    groups = {
      minecraft = { };
      # Shared group for all media services (sonarr/radarr/lidarr/qbittorrent/
      # cross-seed) so they can read+write each other's files for hardlinking
      # and atomic moves. Fixed gid keeps ownership stable across NFS/Samba.
      media = { gid = 987; };
    };
    users = {

      # Give Plex read access to the shared media library.
      plex.extraGroups = [ "media" ];


      redhawk = {
        isNormalUser = true;
        description = "Redhawk";
        extraGroups =
          [ "docker" "minecraft" "networkmanager" "systemd-journal" "wheel" ];
        packages = with pkgs; [ btop neovim starship ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfTvGUneRjHy8UxRmxuxZdNjiiJuhbor5yDfWDUZyrG redhawk@Malos"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL9fxF/yMa5yYlT4lMrwcwtY6VPEW/brz83ZgaYJ1mNM redhawk@Mythra"
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
