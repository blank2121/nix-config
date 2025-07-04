{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.obsidian;
in {
    options.my.apps.obsidian.enable = mkEnableOption "obsidian";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            obsidian
        ];
    };
}
