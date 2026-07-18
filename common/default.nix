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
      value = "524288";
    }
  ];

  # PAM loginLimits only covers tty/ssh logins. Graphical apps (SDDM -> Plasma)
  # are children of the systemd --user manager, whose default soft nofile limit
  # is 1024. Raise the systemd defaults so those sessions get the higher limit.
  systemd.settings.Manager.DefaultLimitNOFILE = "65536:524288";
  systemd.user.extraConfig = "DefaultLimitNOFILE=65536:524288";

}
