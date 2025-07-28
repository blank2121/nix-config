{ lib, config, options, pkgs, username, ... }:

with lib;

let 
    cfg = config.my.apps.programming.copyparty;

in {

    options.my.apps.programming.copyparty.enable = mkEnableOption "copyparty";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = [ pkgs.copyparty ];
    };
}
