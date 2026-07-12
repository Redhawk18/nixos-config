{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.printing {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
        brlaser
      ];
      startWhenNeeded = true;
    };
    hardware.printers = {
      ensurePrinters = [
        {
          name = "HP_ENVY_Pro_6400";
          location = "Home";
          deviceUri = "https://hpe6b24d";
          model = "drv:///hp/hpcups.drv/hp-envy_pro_6400_series.ppd";
        }
        {
          name = "Brother_HL_L2465DW";
          location = "Mom's House";
          deviceUri = "socket://BRW4845E653A3BC";
          model = "drv:///brlaser.drv/brl2460d.ppd";
        }
      ];
      ensureDefaultPrinter = "HP_ENVY_Pro_6400";
    };
  };
}
