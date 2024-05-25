{
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    optimise.dates = [ "18:30" ];

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };
}
