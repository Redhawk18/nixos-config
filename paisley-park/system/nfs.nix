{
  services.nfs = {
    server = {
      enable = true;
      exports = ''
        /boundman/server_files *(rw,sync)
      '';
    };
  };
}
