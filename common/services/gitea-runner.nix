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
        labels = [
          "debian:docker://node:lts-slim"
          "rust:docker://redhawk76/rust"
          "docker:docker://catthehacker/ubuntu:act-latest"
        ];
        settings = {
          container = {
            options = "-v /var/run/docker.sock:/var/run/docker.sock";
            valid_volumes = [ "/var/run/docker.sock" ];
            force_pull = true;
          };
        };
      };
    };
  };
}
