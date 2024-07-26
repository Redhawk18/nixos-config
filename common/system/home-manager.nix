{
  imports = [ <home-manager/nixos> ];
  home-manager.users.redhawk = { config, lib, pkgs, ... }: {
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

        sessionVariables = {
          NIXPKGS_ALLOW_UNFREE = 1;
        };

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

    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = ''${lib.getExe pkgs.curl} -s --json '{"method": "resume", "id": 1}' -H 'Authorization: Bearer password' http://localhost:6969/json_rpc'';
          resumeCommand = ''${lib.getExe pkgs.curl} -s --json '{"method": "pause", "id": 1}' -H 'Authorization: Bearer password' http://localhost:6969/json_rpc'';
        }
      ];
    };

    xdg = {
      # configFile."nvim".source = "/home/redhawk/code/neovim-config/";
      configFile."nvim".source = builtins.fetchGit {
        url = "https://github.com/Redhawk18/neovim-config";
      };
    };
  };
}




