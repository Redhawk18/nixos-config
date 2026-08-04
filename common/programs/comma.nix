{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];

  # Installs comma wrapped with a prebuilt nix-index database so
  # `, <command>` works without generating the index locally.
  programs.nix-index-database.comma.enable = true;
}
