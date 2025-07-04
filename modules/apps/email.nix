{ lib, pkgs, config, options, ... }:

with lib;

let
    cfg = config.my.apps.email;
in {
    options.my.apps.email.enable = mkEnableOption "email";

    config = mkIf cfg.enable {
        programs.thunderbird.enable = true;
    };
}
