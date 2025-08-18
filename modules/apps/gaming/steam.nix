{ lib, pkgs, config, options, username, ... }:

with lib;

let
    cfg = config.my.apps.gaming.steam;
in {
    options.my.apps.gaming.steam.enable = mkEnableOption "steam";

    config = mkIf cfg.enable {
    
        programs.steam.enable = true;
        programs.steam.gamescopeSession.enable = true;
        programs.gamemode.enable = true;

        home-manager.users.${username}.home.packages = with pkgs; [
            mangohud
            protonup
        ];

        environment.sessionVariables = {
            STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
        };
    };
}
