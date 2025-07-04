{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.spotify;
in {
    options.my.apps.spotify.enable = mkEnableOption "spotify";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            spotify
        ];
    };
}
