{ config, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager.users.redhawk =
    { lib, pkgs, ... }:
    {
      home = {
        username = "redhawk";
        homeDirectory = "/home/redhawk";
        stateVersion = "24.05";
      };

      nixpkgs.overlays = [ ];

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
            rust = "nix shell github:oxalica/rust-overlay#rust-nightly nixpkgs#openssl nixpkgs#pkg-config nixpkgs#gcc";
            switch = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
            update = "nix flake update";
          };
        };

        btop = {
          settings = {
            color_theme = "gruvbox_dark_v2.theme";
          };
        };

        git = {
          enable = true;

          settings = {
            credential.helper = "store";

            user = {
              name = "Redhawk18";
              email = "redhawk@redhawkcodes.dev";
            };
          };
        };

        helix = {
          enable = false;
        };

        neovim = {
          enable = true;
          defaultEditor = true;
          withRuby = true;
          withPython3 = true;
          extraPackages = with pkgs; [
            # programs
            git
            lemonade
            ripgrep
            wl-clipboard
            xclip

            # runtimes
            nodejs

            # bash
            bash-language-server
            shfmt

            # c, c++
            clang
            vscode-extensions.llvm-vs-code-extensions.vscode-clangd
            clang-tools
            cmake-language-server

            # docker
            dockerfile-language-server
            docker-compose-language-service

            # javascript
            vscode-langservers-extracted
            typescript-language-server
            svelte-language-server
            vscode-json-languageserver

            # just
            just-lsp

            # lua
            lua-language-server

            # nix
            nixd
            nixfmt

            # python
            pyright
            black
            isort

            # rust
            rustup
            cargo
            rust-analyzer
            vscode-extensions.vadimcn.vscode-lldb.adapter

            # yaml
            yaml-language-server

          ];
        };

        ssh = {
          enable = true;
          enableDefaultConfig = false;

          settings = {
            "*".Compression = true;

            "github.com" = {
              HostName = "github.com";
              User = "git";
              IdentityFile = "/home/redhawk/.ssh/keys/github";
            };

            "gitlab.com" = {
              HostName = "gitlab.com";
              User = "git";
              IdentityFile = "/home/redhawk/.ssh/keys/gitlab";
            };

            mythra = {
              HostName = "mythra";
              User = "redhawk";
              IdentityFile = "/home/redhawk/.ssh/keys/mythra";
            };

            paisley-park = {
              HostName = "paisley-park";
              User = "redhawk";
              IdentityFile = "/home/redhawk/.ssh/keys/paisley-park";
            };

            # Ohio Super Computing
            pitzer = {
              HostName = "pitzer.osc.edu";
              User = "crange";
              IdentityFile = "/home/redhawk/.ssh/keys/osc";
            };

            ascend = {
              HostName = "ascend.osc.edu";
              User = "crange";
              IdentityFile = "/home/redhawk/.ssh/keys/osc";
            };

            cardinal = {
              HostName = "cardinal.osc.edu";
              User = "crange";
              IdentityFile = "/home/redhawk/.ssh/keys/osc";
            };

            # Wright State
            fry = {
              HostName = "fry.cs.wright.edu";
              User = "w180cxr";
              IdentityFile = "/home/redhawk/.ssh/keys/fry";
            };

            # Tars
            poptart = {
              HostName = "poptart.tailfa9236.ts.net";
              User = "redhawk";
              IdentityFile = "/home/redhawk/.ssh/keys/poptart";
            };

            tarsgpu1 = {
              HostName = "tarsgpu1.tailfa9236.ts.net";
              User = "redhawk";
              IdentityFile = "/home/redhawk/.ssh/keys/tarsgpu1";
            };
          };
        };

        starship.enable = true;
      };

      services.ssh-agent.enable = true;
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
