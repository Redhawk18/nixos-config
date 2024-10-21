{ lib, ... }: {
  imports = [ ./nix-ld.nix ];

  options = {
    nix-ld = lib.mkEnableOption "enables nix-ld";
  };
}
