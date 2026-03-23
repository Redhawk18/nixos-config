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
        };
      };

    };

  };
}
