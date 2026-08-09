# Custom packages, exposed as an overlay so they are available as
# `pkgs.<name>` everywhere nixpkgs is used in this flake.
#
# Wire it into a system by adding to nixpkgs.overlays, e.g.:
#   nixpkgs.overlays = [ (import ../../pkgs) ];
final: prev: {
  torrent-cleaner = final.callPackage ./torrent-cleaner { };
}
