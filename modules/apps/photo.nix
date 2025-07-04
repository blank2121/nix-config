{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.photo;
in { 
    options.my.apps.photo.enable = mkEnableOption "photo";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            gthumb
            halftone
        ];
    };
}
