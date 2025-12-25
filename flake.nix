{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Nixos Community
    fenix.url = "github:nix-community/fenix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    rustowl.url = "github:nix-community/rustowl-flake";

    # Community
    nix-minecraft.url = "github:infinidoge/nix-minecraft";
    rust-overlay.url = "github:oxalica/rust-overlay";

    # Dotfiles
    neovim-config = {
      url = "github:redhawk18/neovim-config";
      flake = false;
    };

    # NUR
    nur-xddxdd.url = "github:xddxdd/nur-packages";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        Cinnamoroll = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/cinnamoroll/configuration.nix ];
        };

        Nia = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [
            inputs.nixos-hardware.nixosModules.framework-16-7040-amd
            ./hosts/nia/configuration.nix
          ];
        };

        Malos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/malos/configuration.nix ];
        };

        Mythra = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            rustowl = import inputs.rustowl { };
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/mythra/configuration.nix ];
        };

        Paisley-Park = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            nur-xddxdd = import inputs.nur-xddxdd { };
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/paisley-park/configuration.nix ];
        };

        PopTart = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            rustowl = import inputs.rustowl { };
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/poptart/configuration.nix ];
        };

        Shulk = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/shulk/configuration.nix ];
        };

        WSL = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs nixos-wsl;
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/wsl/configuration.nix ];
        };

      };

    };
}
