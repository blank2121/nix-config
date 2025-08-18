{ lib, pkgs, ... }:

with lib;

{
    boot.loader = {
        grub.enable = true;
        efi.canTouchEfiVariables = true;
    };
}
