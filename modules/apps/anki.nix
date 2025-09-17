{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.anki;
in {
    options.my.apps.anki.enable = mkEnableOption "anki";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            anki-bin
        ];
    };
}
