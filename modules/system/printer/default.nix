{ lib, config, options, pkgs, ... }:

with lib;

let
    cfg = config.my.system.printing;
in {
    options.my.system.printing = {
        enable = mkEnableOption "printing";
    };

    config = mkIf cfg.enable {
        services.printing.enable = true;
        services.printing.drivers = [ pkgs.hplip ];
        services.avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
    };
}
