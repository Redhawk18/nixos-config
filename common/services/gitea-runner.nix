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
          cache = {
            enabled = true;
            host = "172.17.0.1"; # docker0 gateway — reachable from job containers
            port = 34567; # pinned so it's stable + firewall-able
          };
          container = {
            options = "-v /var/run/docker.sock:/var/run/docker.sock";
            valid_volumes = [ "/var/run/docker.sock" ];
            force_pull = true;
          };
        };
      };
    };
    networking.firewall.trustedInterfaces = [ "docker0" ];
  };
}
