# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "msr" "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub.useOSProber = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/5ad21ebf-ca21-410a-8761-2a84207f52c2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/D5C8-0BA4";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/0674520e-474d-47ed-ba43-dd9337be2e6e";
      fsType = "ext4";
    };


  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/56cb89b5-709b-44e9-9135-56dab4576414";
      fsType = "ext4";
    };

  fileSystems."/mnt/games" =
    {
      device = "/dev/disk/by-uuid/53ddb300-4589-48e6-a101-2d77091882e4";
      fsType = "ext4";
    };

  fileSystems."/mnt/windows" =
    {
      device = "/dev/disk/by-uuid/3AEA8E2CEA8DE50B";
      fsType = "ntfs";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp14s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp15s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
