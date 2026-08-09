{
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # Read access to the shared media library (see system/media-storage.nix).
  users.users.plex.extraGroups = [ "media" ];
}
