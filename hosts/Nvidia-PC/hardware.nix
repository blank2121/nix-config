{ modulesPath, lib, config, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Bootloader.
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;


  security.rtkit.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bda61d3a-8b2a-4d55-b5b6-1aa6a8ce7b3d";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # drivers and stuff

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {

    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      nvidiaSettings = true;
      open = true;
      modesetting.enable = true;
    };
  };
}
