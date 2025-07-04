{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.discord;
in {
    options.my.apps.discord.enable = mkEnableOption "discord";

    config = mkIf cfg.enable {
        home-manager.users.${username}.programs.vesktop.enable = true;
    };
}
