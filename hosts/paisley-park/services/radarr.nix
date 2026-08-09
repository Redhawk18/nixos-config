{ unstable, lib, ... }:
{
  services.radarr = {
    enable = true;
    openFirewall = true;
    package = unstable.radarr;
    # Runs as `radarr` in the shared `media` group for hardlinking.
    group = "media";
  };

  # group-writable output (see sonarr.nix / media-storage.nix)
  systemd.services.radarr.serviceConfig.UMask = lib.mkForce "0002";
}
