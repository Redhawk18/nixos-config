{ config, ... }: {
  config.virtualisation.oci-containers.containers = {
    yuzu = {
      image = "yuzuemu/yuzu-multiplayer-dedicated";
      ports = [ "24872:24872" ];
      cmd = [
        #"--bind-address" "0.0.0.0" #doesn't work
        "--enable-yuzu-mods"
        "--max_members"
        "8"
        "--port"
        "24872"
        "--preferred-game"
        "Mario Kart™ 8 Deluxe"
        "--preferred-game-id"
        "0100152000022000"
        "--room-name"
        "Redhawk's room"
        "--room-description"
        "red shell, green shell, blue shell"
        #"--token" "key"
        #"--web-api-url" "https://api.yuzu-emu.org"
      ];
    };
  };
}
