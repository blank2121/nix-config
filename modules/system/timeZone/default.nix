{ lib, config, options, pkgs, ... }:

with lib;

let
    cfg = config.my.system.timeZone;
in {
    options.my.system.timeZone = mkOption { 
        type = types.str;
        default = "America/New_York";
        description = "Set the time zone of this machine.";
    };

    config = {
        time.timeZone = cfg;
    };
}
