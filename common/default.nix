{
  imports = [
    ./coreutils.nix
    ./march.nix

    ./clients/default.nix
    ./desktop/default.nix
    ./programs/default.nix
    ./services/default.nix
    ./system/home-manager.nix
    ./system/nix.nix
    ./system/system.nix
  ];

  nixpkgs.config.allowUnfree = true;
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "65535";
    }
  ];

}
