{ pkgs, ... }:
let
  json = pkgs.formats.json { };
  network = {
    name = "lavalink";
    id = "ec123baea9350a6a4447d389856a83d0ff9f130cee268b4476ca03c7578f1ccb";
    driver = "bridge";
    network_interface = "lavalink";
    subnets = [{
      subnet = "10.0.0.0/8";
      gateway = "10.0.0.1";
    }];
    ipv6_enabled = false;
    internal = false;
    dns_enabled = true;
    ipam_options = { driver = "host-local"; };
  };
  projectPath = "/home/redhawk/code/Bongo-Bot";
in {
  environment.etc."/containers/networks/lavalink.json".source =
    json.generate "lavalink.json" network;

  virtualisation.oci-containers.containers = {
    bongo-bot = {
      image = "ghcr.io/redhawk18/bongo-bot:latest";
      dependsOn = [ "lavalink" ];
      extraOptions = [ "--network=lavalink" ];
      environment = {
        LAVALINK_HOST = "10.0.0.2";
        LAVALINK_PORT = "2333";
        LAVALINK_PASSWORD = "password";
      };
      environmentFiles = [ "${projectPath}/.env" ];
      volumes = [ "${projectPath}/bongo.sqlite:/app/bongo.sqlite" ];
    };

    lavalink = {
      image = "ghcr.io/lavalink-devs/lavalink:3-alpine";
      extraOptions = [
        "--ip=10.0.0.2"
        "--hostname=lavalink"
        "--network=lavalink"
      ];
      ports = [ "2333:2333" ];
      volumes =
        [ "${projectPath}/application.yml:/opt/Lavalink/application.yml" ];
    };

  };
}
