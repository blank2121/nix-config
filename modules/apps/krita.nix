{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.krita;
in {
    options.my.apps.krita.enable = mkEnableOption "krita";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            krita
        ];
    };
}
