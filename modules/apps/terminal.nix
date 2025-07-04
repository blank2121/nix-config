{ config, options, lib, username, ... }:

with lib;

let
    cfg = config.my.apps.terminal;
in {
    options.my.apps.terminal.enable = mkEnableOption "terminal";

    config = mkIf cfg.enable {
        home-manager.users.${username}.programs.kitty = {
            enable = true;
            settings = {
              enable_audio_bell = false;
            };
            extraConfig = ''
              background_opacity 0.85
            '';
          };
    };
}
