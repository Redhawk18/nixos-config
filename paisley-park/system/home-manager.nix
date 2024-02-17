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
          switch = "sudo nixos-rebuild switch";
          update = "sudo nix-channel --update && sudo nixos-rebuild switch";
        };
      };

      git = {
        enable = true;
        userName = "Redhawk18";
        userEmail = "redhawk76767676@gmail.com";
      };

      neovim = {
        enable = true;
        defaultEditor = true;
        withNodeJs = true;
        withPython3 = true;
        extraPackages = with pkgs; [
          nil
          nixfmt 
          ripgrep
          rustup
          unzip
          wl-clipboard
          xclip
        ];
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

    xdg = {
      # configFile."nvim".source = "/home/redhawk/code/neovim-config/";
            configFile."nvim".source = builtins.fetchGit {
              url = "https://github.com/Redhawk18/neovim-config";
            };
    };
  };
}
