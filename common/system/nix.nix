{
  nix = {
    gc =
      {
        automatic = true;
        options = "--delete-older-than 30d";
      };
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };
}
