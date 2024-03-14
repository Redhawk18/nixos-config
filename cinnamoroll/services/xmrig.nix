{ pkgs, ...}: {

services.xmrig = {
  enable = true;
  package = pkgs.xmrig-mo;
  settings = {
    autosave = true;
    cpu = true;
    opencl = false;
    cuda = false;
    pools = [
      {
        url = "gulf.moneroocean.stream:10032";
        user = "45ynyPQi18vNFvoDGvoT6W6RyrdeahPurVvpxajc4d116fz4jWsqzFD2HkDFMoVp4Zeqvi17kRZt9Lna8Lt8xeZdShzLnkW";
        rig-id = "Paisley-Park";
        keepalive = true;
        tls = true;
      }
    ];
  };
};
}
