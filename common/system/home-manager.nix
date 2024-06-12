{
  imports = [ <home-manager/nixos> ];
  home-manager.users.redhawk = { config, pkgs, ... }: {
    home = {
      username = "redhawk";
      homeDirectory = "/home/redhawk";
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;

      bash = {
        enable = true;

        initExtra = ''
          eval "$(starship init bash)"
        '';

        shellAliases = {
          ".." = "cd ..";
          ll = "ls -lah";
          switch = "sudo nixos-rebuild switch";
          update = "sudo nixos-rebuild switch --upgrade";
        };
      };

      btop = {
        settings = { color_theme = "gruvbox_dark_v2.theme"; };
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      git = {
        enable = true;
        userName = "Redhawk18";
        userEmail = "redhawk76767676@gmail.com";
      };

      neovim = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
          clang
          git
          lemonade
          nixd
          nixpkgs-fmt
          nodejs
          python3
          ripgrep
          rustup
          rust-analyzer
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

          "gitlab.com" = {
            hostname = "gitlab.com";
            user = "git";
            identityFile = "/home/redhawk/.ssh/keys/gitlab";
          };

          paisley-park = {
            hostname = "paisley-park.lan";
            user = "redhawk";
            identityFile = "/home/redhawk/.ssh/keys/paisley-park";
          };
        };
      };
    };

    xdg = {
      #configFile."nvim".source = "/home/redhawk/code/neovim-config/";
      configFile."nvim".source = builtins.fetchGit {
        url = "https://github.com/Redhawk18/neovim-config";
      };
    };
  };
}
