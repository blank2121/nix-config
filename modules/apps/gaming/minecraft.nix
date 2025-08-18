{ lib, pkgs, config, options, username, ... }:

with lib;

let
    cfg = config.my.apps.gaming.minecraft;
in {
    options.my.apps.gaming.minecraft.enable = mkEnableOption "minecraft";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [
            prismlauncher
        ];
    };
}
