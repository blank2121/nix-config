{ lib, pkgs, ... }:

with lib;

{
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };
}
