{ config, pkgs, ... }:
{
  services = {
    forgejo = {
      enable = true;
      lfs = {
        enable = true;
        contentDir = "/boundman/git/";
      };
      settings = {
        server = {
          PROTOCOL = "http";
          HTTP_ADDR = "127.0.0.1";
          HTTP_PORT = 8083;
          DOMAIN = "git.redhawkcodes.dev";
          ROOT_URL = "https://git.redhawkcodes.dev/";
          REQUIRE_SIGNIN_VIEW = true;
          DISABLE_REGISTRATION = true;
        };
        "service.explore" = {
          DISABLE_USERS_PAGE = true;
        };
      };
    };
  };
}
