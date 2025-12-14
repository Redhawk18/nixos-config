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
          DOMAIN = "${config.networking.hostName}";
          HTTP_PORT = 8083;
        };
      };

    };

    gitea-actions-runner = {
      package = pkgs.forgejo-runner;

      instances."${config.networking.hostName}" = {
        name = "${config.networking.hostName}";
        enable = true;
        url = "http://${config.services.forgejo.settings.server.DOMAIN}:${toString config.services.forgejo.settings.server.HTTP_PORT}";
        token = "2LjAoI4Jo38H3xmzjiu8xkiBedLvnfElZL1DRCyf";
        labels = [ "debian:docker://node:lts-slim" ];
      };
    };
  };
}
