{ config, lib, pkgs, ... }: {

  config = lib.mkIf config.nix-ld {
    environment.systemPackages = with pkgs; [
      nix-ld
    ];

    programs.nix-ld = {
      enable = true;
      libraries =
        with pkgs;
        [
          fuse
          libGL
          wayland
          egl-wayland
          libxkbcommon
          openal
          SDL2
          xorg.libX11
        ]
        ++ (
          if (config.hardware.pulseaudio.enable || config.services.pipewire.pulse.enable) then
            [ pulseaudio ]
          else
            [ alsa-lib ]
        );
    };
  };

}
