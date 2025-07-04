{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.mpv;
in {
    options.my.apps.mpv.enable = mkEnableOption "mpv";

    config = mkIf cfg.enable {
        home-manager.users.${username}.programs.mpv.enable = true;
    };
}
