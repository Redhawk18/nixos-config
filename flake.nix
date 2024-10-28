{
  description = "System flake";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixos";
    };

    neovim-config = {
          url = "github:redhawk18/neovim-config";
      flake = false;
    };

    ryujinx = {
        url = "github:ryujinx-mirror/ryujinx";
        flake = false;

};
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        Mythra = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./hosts/mythra/configuration.nix ];
        };
      };
    };
}
