{
  config,
  options,
  lib,
  username,
  ...
}:

with lib;

let
    cfg = config.my.desktops.extras.wlogout;
in {
  options = {
    my.desktops.extras.wlogout.enable = mkEnableOption "wlogout";
  };

  config = mkIf cfg.enable {
      home-manager.users.${username}.programs.wlogout = {
          enable = true;
          style = ''
              window {
                  background-color: rgba(129, 51, 184, 0.1);
              }
          '';
      };
  };
}
