{
  config,
  options,
  lib,
  pkgs,
  username,
  ...
}:

with lib;

let
    cfg = config.my.desktops.extras.swaync;
in {
  options.my.desktops.extras.swaync.enable = mkEnableOption "swaync";
    
  config = mkIf cfg.enable {
      home-manager.users.${username} = {
          services.swaync = {
              enable = true;
              settings = { };
              style = '''';
          };
          services.batsignal.enable = true;

          home.packages = with pkgs; [
              swaynotificationcenter
              libnotify
          ];
      };
  };
}
