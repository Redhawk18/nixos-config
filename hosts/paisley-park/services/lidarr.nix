{ unstable, ... }:
{
  services.lidarr = {
    enable = true;
    openFirewall = true;
    package = unstable.lidarr;
    user = "root";
  };
}
