let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in {
  imports = [ "${home-manager}/nixos" ];
  home-manager.users.redhawk = { config, pkgs, ... }: {
    home.stateVersion = "23.05";
    programs = {
      home-manager.enable = true;

      bash = {
        enable = true;

        initExtra = ''
          PS1="\n\e[1;31m─\u\e[1m💾\e[1;95m\h\e[1m─ \e[1;34m\w\e[0m \n \e[1;31m└\$ \e[0m"
          PS2="=>"
        '';

        sessionVariables = {
          # Rust
          RUST_LOG = "info";
        };

        shellAliases = {
          ".." = "cd ..";
          ll = "ls -lah";
          shutdown = "loginctl poweroff";
          switch = "sudo nixos-rebuild switch";
          update = "sudo nix-channel --update && sudo nixos-rebuild switch";
          reboot = "loginctl reboot";
        };
      };

      git = {
        enable = true;
        userName = "Redhawk18";
        userEmail = "redhawk76767676@gmail.com";
      };

      ssh = {
        enable = true;
        compression = true;

        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/home/redhawk/.ssh/keys/github";
          };
        };
      };
    };
  };
}
