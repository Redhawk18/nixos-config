{ config, unstable, ... }:
{
  services.ollama = {
    enable = true;
    package = unstable.ollama-cuda;
    acceleration = "cuda";
    openFirewall = true;
    user = "ollama";
    group = "ollama";
    # home = "/home/ollama";
    # models = "${config.services.ollama.home}/models";
    loadModels = [ ];

  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    port = 8082;
    environment = {
      OLLAMA_API_BASE_URL = " http://127.0.0.1:11434 ";
      # Disable authentication
      WEBUI_AUTH = "False";
    };
  };
}
