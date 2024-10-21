{
  description = "System flake";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixos";
    };

  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations.mythra = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/mythra/configuration.nix ];
    };
  };
}
