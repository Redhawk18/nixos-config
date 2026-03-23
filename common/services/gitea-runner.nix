{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.gitera-runner {
    services.gitea-actions-runner = {
      package = pkgs.forgejo-runner;

      instances."redhawkcodes" = {
        name = "${config.networking.hostName}";
        enable = true;
        url = "https://git.redhawkcodes.dev";
        tokenFile = "/var/lib/gitea-runner/forgejo.token";
        labels = [ "debian:docker://node:lts-slim" ];
      };
    };
  };
}
