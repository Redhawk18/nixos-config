{ unstable, ... }:
{
  services.prowlarr = {
    enable = true;
    openFirewall = true;
    package = unstable.prowlarr;
  };
}
