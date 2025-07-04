{ pkgs, config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.godot;
in {
    options.my.apps.godot.enable = mkEnableOption "godot";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            godot
        ];
    };
}
