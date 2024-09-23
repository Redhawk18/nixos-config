{ config, ... }: {
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;

    settings = {
      sunshine_name = config.networking.hostName;
      controller = true;
      output_name = 1;

      min_threads = 8;
      encoder = "amdvce";

      amd_usage = "ultralowlatency";
      amd_quality = "speed";
      amd_coder = "cavlc";
    };
  };
}
