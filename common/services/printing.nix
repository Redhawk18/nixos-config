{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ hplip ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_ENVY_Pro_6400";
        location = "Home";
        deviceUri = "https://hpe6b24d.lan";
        model = "drv:///hp/hpcups.drv/hp-envy_pro_6400_series.ppd";
      }
    ];
    ensureDefaultPrinter = "HP_ENVY_Pro_6400";
  };
}
