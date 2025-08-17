{ lib, pkgs, config, options, ... }:

with lib;

let
    cfg = config.my.system.boot.grub; 
in {
    options = {
        my.system.boot.grub.enable = mkEnableOption "grub";
    };

    config = {
        boot.loader = {
            grub.enable = cfg.enable;
            systemd-boot.enable = !cfg.enable;
            efi.canTouchEfiVariables = !cfg.enable;
        };
    };
}
