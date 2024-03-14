{
  services.nfs = {
    server = {
      enable = true;
      exports = ''
        /var/share *(rw,sync)
	  '';
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };
}
