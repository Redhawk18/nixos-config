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
          DOMAIN = "git.redhawkcodes.dev";
          HTTP_PORT = 8083;
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
