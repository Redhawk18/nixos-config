{ unstable, lib, ... }:
{
  services.lidarr = {
    enable = true;
    openFirewall = true;
    package = unstable.lidarr;
    # Runs as `lidarr` in the shared `media` group for hardlinking.
    group = "media";
  };

  # group-writable output (see sonarr.nix / media-storage.nix)
  systemd.services.lidarr.serviceConfig.UMask = lib.mkForce "0002";
}
