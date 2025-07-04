{ pkgs, config, options, lib, inputs, username, ... }:

with lib;

let
    cfg = config.my.apps.zen;
in {
    options.my.apps.zen.enable = mkEnableOption "zen";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with inputs; [
            zen-browser.packages."${pkgs.system}".default
        ];
    };
}
