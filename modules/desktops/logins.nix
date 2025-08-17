{
  config,
  lib,
  ...
}:

with lib;

let 
    cfg = config.my.desktops.login;
in {
  options = {
    my.desktops.login.ly.enable = mkEnableOption "ly login";
    my.desktops.login.sddm.enable = mkEnableOption "sddm login";
  };

  config = {
    services.displayManager.ly.enable = cfg.ly.enable;
    services.displayManager.sddm = mkIf cfg.sddm.enable {
      enable = true; 
      wayland.enable = true;
      enableHidpi = true;
    };
  };
}
