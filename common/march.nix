{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Packages to not be optimized, for example libreoffice.
  pure = import pkgs.path {
    inherit (config.nixpkgs) config;
    overlays = [ ];
  };
in
{
  options.march = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable native CPU optimizations (-march=native), could take days!";
  };

  config = lib.mkMerge [
    # Always export pure, regardless of march status
    {
      _module.args = { inherit pure; };
    }

    (lib.mkIf (config.march or false) {
      nixpkgs.overlays = [
        (final: prev: {
          # stdenv = prev.impureUseNativeOptimizations prev.stdenv;
          rustPlatform = prev.rustPlatform // {
            buildRustPackage =
              args:
              let
                # Call the original buildRustPackage
                pkg = prev.rustPlatform.buildRustPackage args;
              in
              # Override the resulting derivation to add the RUSTFLAGS
              pkg.overrideAttrs (old: {
                RUSTFLAGS = "${old.RUSTFLAGS or ""} -C target-cpu=${config.nixpkgs.hostPlatform.gcc.arch}";
              });
          };

          python3Packages = prev.python3Packages.overrideScope (
            pyFinal: pyPrev: {
              anyio = pyPrev.anyio.overrideAttrs (oldAttrs: {
                doCheck = false;
              });
              rich = pyPrev.rich.overrideAttrs (oldAttrs: {
                doCheck = false;
              });
              sh = pyPrev.sh.overrideAttrs (oldAttrs: {
                doCheck = false;
              });
            }
          );

          assimp = prev.assimp.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          gsl = prev.gsl.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          glog = prev.glog.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          folly = prev.folly.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          simde = prev.simde.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          opencolorio = prev.opencolorio.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          # Valgrind tests.
          rapidjson = prev.rapidjson.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          ffmpeg-headless = prev.ffmpeg-headless.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          ffmpeg = prev.ffmpeg.overrideAttrs (oldAttrs: {
            doCheck = false;
          });
          attoparsec = prev.attoparsec.overrideAttrs (oldAttrs: {
            doCheck = false;
          });

          openldap = prev.openldap.overrideAttrs (oldAttrs: {
            doCheck = false;
          });

          p11-kit = prev.p11-kit.overrideAttrs (oldAttrs: {
            doCheck = false;
          });

          # ibus = prev.ibus.overrideAttrs (old: {
          #   extraBuildFlags = builtins.filter (
          #     flag: !(prev.lib.hasPrefix "-march=" flag) && !(prev.lib.hasPrefix "-mtune=" flag)
          #   ) (old.extraBuildFlags or [ ]);
          # });

          # rsync = prev.rsync.overrideAttrs (old: {
          #   doCheck = false;
          # });

        })
      ];
    })
  ];
}
