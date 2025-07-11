{ config, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  # nixpkgs.overlays = [ inputs.rustowl.overlays.default ];

  home-manager.users.redhawk =
    { lib, pkgs, ... }:
    {
      home = {
        username = "redhawk";
        homeDirectory = "/home/redhawk";
        stateVersion = "24.05";
      };

      nixpkgs.overlays = [
        # inputs.rustowl.overlays.default
        # inputs.fenix.overlays.default
      ];

      programs = {
        home-manager.enable = true;

        bash = {
          enable = true;

          initExtra = ''
            eval "$(starship init bash)"
          '';

          sessionVariables = {
            NIXPKGS_ALLOW_INSECURE = 1;
            NIXPKGS_ALLOW_UNFREE = 1;
            CODELLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/";
          };

          shellAliases = {
            ".." = "cd ..";
            gc = "sudo nix-store --gc && sudo nix-collect-garbage -d";
            ll = "ls -lah";
            switch = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
            update = "nix flake update";
          };
        };

        btop = {
          settings = {
            color_theme = "gruvbox_dark_v2.theme";
          };
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        git = {
          enable = true;
          userName = "Redhawk18";
          userEmail = "77415970+Redhawk18@users.noreply.github.com";
        };

        neovim = {
          enable = true;
          defaultEditor = true;
          extraPackages = with pkgs; [
            # programs
            git
            lemonade
            ripgrep
            wl-clipboard
            xclip

            # runtimes
            nodejs
            python3

            # bash
            nodePackages.bash-language-server
            shfmt

            # c, c++
            clang
            vscode-extensions.llvm-vs-code-extensions.vscode-clangd
            clang-tools

            # docker
            dockerfile-language-server-nodejs
            docker-compose-language-service

            # javascript
            vscode-langservers-extracted
            nodePackages.typescript-language-server
            nodePackages.svelte-language-server

            # lua
            luajitPackages.lua-lsp

            # nix
            nixd
            nixfmt-rfc-style

            # python
            pyright
            black
            isort

            # rust
            rustup
            rust-analyzer
            vscode-extensions.vadimcn.vscode-lldb

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

            mythra = {
              hostname = "mythra.lan";
              user = "redhawk";
              identityFile = "/home/redhawk/.ssh/keys/mythra";
            };

            paisley-park = {
              hostname = "paisley-park.lan";
              user = "redhawk";
              identityFile = "/home/redhawk/.ssh/keys/paisley-park";
            };

            fry = {
              hostname = "fry.cs.wright.edu";
              user = "w180cxr";
              identityFile = "/home/redhawk/.ssh/keys/fry";
            };

            pitzer = {
              hostname = "pitzer.osc.edu";
              user = "crange";
              identityFile = "/home/redhawk/.ssh/keys/pitzer";
            };

          };
        };

        starship.enable = true;
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
        configFile."nvim".source = inputs.neovim-config;
      };
    };
}
