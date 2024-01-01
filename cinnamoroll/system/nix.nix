{
  nix = {
    gc = {
      automatic = true;
      dates = "monthly";
    };

	optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
