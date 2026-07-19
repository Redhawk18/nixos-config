{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    # ai tooling comes along whenever development is enabled
    { ai = lib.mkDefault config.desktop.programming; }

    (lib.mkIf config.ai {
      environment.systemPackages = [
        pkgs.claude-code
      ];
    })
  ];
}
