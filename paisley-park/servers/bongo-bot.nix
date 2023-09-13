{ pkgs, ... }:
let
  json = pkgs.formats.json { };
  network = {
    name = "bongo-bot";
    id = "ec123baea9350a6a4447d389856a83d0ff9f130cee268b4476ca03c7578f1ccb";
    driver = "bridge";
    network_interface = "bongo-bot";
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
  environment.etc."/containers/networks/bongo-bot.json".source =
    json.generate "bongo-bot.json" network;

  virtualisation.oci-containers.containers = {
    bongo-bot = {
      image = "ghcr.io/redhawk18/bongo-bot:latest";
      dependsOn = [ "lavalink" "postgres" ];
      extraOptions = [ "--network=bongo-bot" "--pull=newer" ];
      environment = {
        POSTGRES_DATABASE = "bongo";
        POSTGRES_HOST = "10.0.0.3";
        POSTGRES_PORT = "5432";
        POSTGRES_USER = "postgres";

        LAVALINK_HOST = "10.0.0.2";
        LAVALINK_PORT = "2333";
        LAVALINK_PASSWORD = "password";
      };
      environmentFiles = [ "${projectPath}/.env" ];
    };

    lavalink = {
      image = "ghcr.io/lavalink-devs/lavalink:3-alpine";
      extraOptions = [
        "--ip=10.0.0.2"
        "--hostname=lavalink"
        "--network=bongo-bot"
        "--pull=newer"
      ];
      ports = [ "2333:2333" ];
      volumes =
        [ "${projectPath}/application.yml:/opt/Lavalink/application.yml" ];
    };

    postgres = {
      image = "postgres";
      extraOptions = [
        "--ip=10.0.0.3"
        "--hostname=postgres"
        "--mount=type=volume,source=bongo-bot-postgres,destination=/data/postgres,rw=true"
        "--network=bongo-bot"
        "--pull=newer"

      ];
      environment = {
        POSTGRES_USER = "postgres";
        PGDATA = "/data/postgres";
      };
      environmentFiles = [ "${projectPath}/.env" ];
      #volumes = [ "${projectPath}/postgres:/data/postgres" ];
    };

  };
}
