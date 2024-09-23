{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    btop
    busybox
    docker
    docker-compose
    fd
    git
    home-manager
    neovim
    nix-ld
    wget
  ];

  programs.nix-ld = {
    enable = true;
    libraries =
      with pkgs;
      [
        wayland
        egl-wayland
        libxkbcommon
        xorg.libX11
        libGL
      ]
      ++ (
        if (config.hardware.pulseaudio.enable || config.services.pipewire.pulse.enable) then
          [ pulseaudio ]
        else
          [ alsa-lib ]
      );
  };
}
