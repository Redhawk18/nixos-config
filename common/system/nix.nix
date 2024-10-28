{inputs, ...}: {
  nix = {
    gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
    optimise.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };
}
