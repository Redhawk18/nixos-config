{ pkgs, inputs, ... }:
let
  blog = inputs.blog.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    virtualHosts."www.redhawkcodes.dev" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8000;
        }
      ];
      root = blog;
      extraConfig = "port_in_redirect off;";
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels."07cf8e4f-b890-4ee9-ba7f-5a9671c06d32" = {
      credentialsFile = "/var/lib/cloudflared/07cf8e4f-b890-4ee9-ba7f-5a9671c06d32.json";
      ingress = {
        "www.redhawkcodes.dev" = "http://localhost:8000";
        "git.redhawkcodes.dev" = "http://localhost:8001";
      };
      default = "http_status:404";
    };
  };
}
