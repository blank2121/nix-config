{
  config,
  lib,
  options,
  username,
  ...
}:

with lib;

let 
    cfg = config.my.desktops.extras.swaylock;
in{
  options = {
    my.desktops.extras.swaylock.enable = mkEnableOption "swaylock";
  };

  config = mkIf cfg.enable {
      home-manager.users.${username}.programs.swaylock = {
          enable = true;
          settings = {
              indicator-idle-visible = false;
              indicator-radius = 100;
              show-failed-attempts = true;
          };
      };
  };
}
