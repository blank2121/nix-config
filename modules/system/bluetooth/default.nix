{ lib, config, options, pkgs, ... }:

with lib;

let
    cfg = config.my.system.bluetooth;
in {

    options.my.system.bluetooth = {
        enable = mkEnableOption "bluetooth";
    };

    config = mkIf cfg.enable {
        hardware = {
            bluetooth.enable = true;
            bluetooth.powerOnBoot = true;
        };
        services.blueman.enable = true;
    };
}
