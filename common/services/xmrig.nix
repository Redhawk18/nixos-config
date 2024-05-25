{ config, pkgs, ... }: {

  services.xmrig = {
    enable = true;
    package = pkgs.xmrig-mo;
    settings = {
      autosave = true;
      randomx = {
        "1gb-pages" = true;
      };
      cpu =
        {
          enabled = true;
          priority = 5;
        };
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "gulf.moneroocean.stream:20128";
          user = "45ynyPQi18vNFvoDGvoT6W6RyrdeahPurVvpxajc4d116fz4jWsqzFD2HkDFMoVp4Zeqvi17kRZt9Lna8Lt8xeZdShzLnkW";
          rig-id = "${config.networking.hostName}";
          keepalive = true;
          tls = true;
        }
      ];
      pause-on-battery = true;
    };
  };
}
