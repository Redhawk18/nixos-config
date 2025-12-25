{
  config,
  lib,
  pkgs,
  ...
}:
let
  xmrig-pause = pkgs.writeShellScriptBin "xmrig-pause" ''
    curl -s --json '{"method": "pause", "id": 1}' -H 'Authorization: Bearer password' http://localhost:6969/json_rpc
  '';

  xmrig-resume = pkgs.writeShellScriptBin "xmrig-resume" ''
    curl -s --json '{"method": "resume", "id": 1}' -H 'Authorization: Bearer password' http://localhost:6969/json_rpc
  '';
in
{
  config = lib.mkIf config.xmrig {
    nixpkgs.overlays = [
      (final: prev: {
        xmrig-mo = prev.xmrig-mo.overrideAttrs (oldAttrs: {
          NIX_CFLAGS_COMPILE = (oldAttrs.NIX_CFLAGS_COMPILE or "") + " -march=native -mtune=native";

          #           cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          #             "-DWITH_ADL=OFF" # Optional: disable if not using AMD ADL
          #             "-DCMAKE_C_FLAGS=-march=native"
          #             "-DCMAKE_CXX_FLAGS=-march=native"
          #           ];

          doCheck = false;
        });
      })
    ];

    services.xmrig = {
      enable = true;
      package = pkgs.xmrig-mo;
      settings = {
        autosave = true;
        http = {
          enabled = true;
          host = "127.0.0.1";
          port = 6969;
          access-token = "password";
          restricted = false;
        };
        randomx = {
          "1gb-pages" = true;
        };
        cpu = {
          enabled = true;
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
    boot.kernel.sysctl."vm.nr_hugepages" = 1280;
    environment.systemPackages = [
      xmrig-pause
      xmrig-resume
    ];
  };
}
