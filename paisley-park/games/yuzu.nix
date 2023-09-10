{ config, ... }: {
  config.virtualisation.oci-containers.containers = {
    yuzu = {
      image = "yuzuemu/yuzu-multiplayer-dedicated";
      ports = [ "5000:5000" ];
      cmd = [
        "--enable-yuzu-mods"
        "--max_members=8"
        "--port=5000"
        "--preferred-game=Mario Kart™ 8 Deluxe"
        "--preferred-game-id=0100152000022000"
        "--room-name=Redhawk's Mariokart 8 Deluxe server"
        "--room-description=red shell, green shell, blue shell"
        #--token "key"
        #--web-api-url https://api.yuzu-emu.org
      ];
    };
  };
}
