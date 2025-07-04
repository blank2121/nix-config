{ lib, config, options, hostname, ... }:

with lib;

let
    cfg = config.my.system.networking; 
in {

    options.my.system.networking = {
        enable = mkEnableOption "networking";
    };

    config = mkIf cfg.enable {
        networking = {
            hostName = hostname;
            networkmanager.enable = true;
        };
    };
}
