{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [
    inputs.led-matrix-daemon.nixosModules.default
    inputs.led-matrix-monitoring.nixosModules.default
  ];

  # Renders the frames onto the Framework 16 LED matrices.
  services.led-matrix-daemon = {
    enable = true;
    # Pin the package to avoid the module default's deprecated `pkgs.system`.
    package = inputs.led-matrix-daemon.packages.${system}.default;
  };

  # Collects system metrics and sends them to the daemon's socket.
  services.led-matrix-monitoring = {
    enable = true;
    package = inputs.led-matrix-monitoring.packages.${system}.default;
    settings = {
      # Override defaults from the upstream example_config.toml.
      # socket path is auto-set from the led-matrix-daemon module above.
      collector.max_history_samples = 20;
      collector.sample_interval = "200ms";
    };
  };
}
