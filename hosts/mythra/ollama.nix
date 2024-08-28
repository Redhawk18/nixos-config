{
  services.ollama = {
    enable = true;
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "10.1.0";
    };
  };

  services.open-webui = {
    #    enable = true;
    openFirewall = true;
    port = 8082;
    environment = {
      OLLAMA_API_BASE_URL = " http://127.0.0.1:11434 ";
      # Disable authentication
      WEBUI_AUTH = "
      False ";
    };
  };
}


