{ config, lib, ... }:
let
  user = "redhawk";
in
{
  config = lib.mkIf config.syncthing {
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      openDefaultPorts = true; # TCP/UDP 22000 UDP 21027
      overrideFolders = false;

      user = "${user}";
      dataDir = "/home/${user}";
      configDir = "/home/${user}/.config";

      settings.devices."cinnamoroll".id =
        "DBLLBEA-WU4HQ2V-WVET622-NMR6L7L-7XPTHPK-F2OX2IZ-NCUAQGY-HNPULAE";
      settings.devices."Nia".id = "ZHCI2HS-IXEANWO-I2RXULS-FAEFGEA-H6BI73F-TGRTI2D-BE4G7D7-GCXRTQG";
      settings.devices."Mythra".id = "UEN335T-27HR62N-ULJMQCF-XKQ26ZS-EAK4CCY-STSSXTK-S65PO63-5SIEWAC";
      settings.devices."Paisley-Park".id =
        "HYS7CC6-I4BKAQL-ZIZL23L-LQR5PK6-OJ2HGVW-HQU64QD-UQQLDTQ-JXPZSAG";
      settings.devices."Poptart".id = "ETGPVEU-O6Q4DXM-3RLBTAD-O2JY5EA-NLMM33J-5DEOQFE-6SH7KMT-FZQFNA7";
      settings.devices."Pyra".id = "V5KKKJU-ZQP4L2V-YS5DUPY-2YDZAHD-RGNBHFW-IEAQMOD-PFZYVTQ-WCAUAQ6";
      settings.devices."Toast-em".id = "YGWIEGD-WFUCIX7-CK4TOH5-TRE4BND-IEIDVRX-F7XRFG2-EAEIZMC-DYNFZQV";
    };

    networking.firewall = {
      allowedTCPPorts = [ 8384 ];
    };
  };
}
