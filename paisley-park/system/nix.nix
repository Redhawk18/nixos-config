{
  nix = {
    gc = {
      automatic = true;
      dates = "monthly";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
