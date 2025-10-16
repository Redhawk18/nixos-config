{ inputs, pkgs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 15d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    optimise.automatic = true;
    package = pkgs.nixVersions.latest;

    settings = {
      download-buffer-size = 524288000; # 500MB
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      trusted-users = [ "@wheel" ];
      substituters = [ "https://devenv.cachix.org" ];
      trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
    };
  };
}
