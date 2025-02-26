# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelModules = [
    "msr"
    "kvm-amd"
  ];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c9785683-2767-45a4-8b08-72e8bbfa1baf";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DE25-82E4";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/56cb89b5-709b-44e9-9135-56dab4576414";
    fsType = "ext4";
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/ffb23ab3-42ec-4650-b555-a1d1935e7c71";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/3AEA8E2CEA8DE50B";
    fsType = "ntfs";
    options = [ "nofail" ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp14s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp15s0.useDHCP = lib.mkDefault true;

  nixpkgs = {
    config.rocmSupport = true;
    localSystem = {
      # The system will take many hours and run out of space to rebuild with native support
      #      gcc.arch = "znver4";
      #      gcc.tune = "znver4";
      system = "x86_64-linux";
    };

    system = lib.mkDefault "x86_64-linux";
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    opengl = {
      enable = true;
      # driSupport = true;
      driSupport32Bit = true;
    };
    amdgpu.opencl.enable = true;

    bluetooth.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    corectrl
    kdePackages.partitionmanager
  ];

}
