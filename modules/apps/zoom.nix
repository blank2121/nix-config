{ config, options, lib, ... }:

with lib;

let
    cfg = config.my.apps.zoom;
in {
    options.my.apps.zoom.enable = mkEnableOption "zoom";

    config = mkIf cfg.enable {
        programs.zoom-us.enable = true;
    };
}
