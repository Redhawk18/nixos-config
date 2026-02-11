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
      substituters = [
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos-cuda.org"
        "http://poptart.tailfa9236.ts.net:47715/poptart"

      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        "poptart:KLcn0YOyLnJBFCnsgVwpSxCXg34s4oEDt0ky8ItpqRk="
      ];
    };
  };
}
