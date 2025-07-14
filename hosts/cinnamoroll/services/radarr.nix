{ unstable, ... }:
{
  services.radarr = {
    enable = true;
    openFirewall = true;
    package = unstable.radarr;
    user = "root";
  };
}
