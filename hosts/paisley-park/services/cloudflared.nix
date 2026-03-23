{
  services.cloudflared = {
    enable = true;

    tunnels."07cf8e4f-b890-4ee9-ba7f-5a9671c06d32" = {
      credentialsFile = "/var/lib/cloudflared/07cf8e4f-b890-4ee9-ba7f-5a9671c06d32.json";
      ingress = {
        "git.redhawkcodes.dev" = "http://localhost:8083";
        # "git-ssh.yourdomain.com" = "ssh://localhost:2222";
        # "www.redhawkcodes.dev" = "http://localhost:80";
      };
      default = "http_status:404";
    };
  };
}
