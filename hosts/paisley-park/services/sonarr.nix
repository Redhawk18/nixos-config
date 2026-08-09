{ lib, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    # Runs as the `sonarr` user but in the shared `media` group so it can
    # hardlink downloads into the library. See system/media-storage.nix.
    group = "media";
  };

  # umask 0002 -> files 664, dirs 775, i.e. group-writable so the other media
  # services can import/upgrade/delete each other's files.
  systemd.services.sonarr.serviceConfig.UMask = lib.mkForce "0002";
}
