{
  nix = {
    gc = {
      automatic = true;
      dates = "monthly";
    };
    
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
