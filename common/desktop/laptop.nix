{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.desktop.laptop {
    services.automatic-timezoned.enable = true;

    services.geoclue2 = {
      enable = true; # redundant but explicit
      geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
    };

    time.timeZone = lib.mkForce null;
  };
}
