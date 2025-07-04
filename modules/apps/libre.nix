{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.libre;
in {
    options.my.apps.libre.enable = mkEnableOption "libre";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            libreoffice
        ];
    };
}
