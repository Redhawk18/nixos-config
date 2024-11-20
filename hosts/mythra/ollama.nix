{
  services.ollama = {
    enable = true;
    home = "/home/ollama";
    models = "/home/ollama/models";
    #    writablePaths = [ "/home/ollama" ];
    #    sandbox = false;
  };

  services.open-webui = {
    # enable = true;
    openFirewall = true;
    port = 8082;
    environment = {
      OLLAMA_API_BASE_URL = " http://127.0.0.1:11434 ";
      # Disable authentication
      WEBUI_AUTH = "False";
    };
  };
}
