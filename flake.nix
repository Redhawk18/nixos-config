{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:infinidoge/nix-minecraft";

    neovim-config = {
      url = "github:redhawk18/neovim-config";
      flake = false;
    };

    nur-xddxdd.url = "github:xddxdd/nur-packages";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
