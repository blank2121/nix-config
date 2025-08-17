{
  config,
  lib,
  pkgs,
  username,
  ...
}:

with lib;

let
    cfg = config.my.desktops.plasma;
in {
  options = {
    my.desktops.plasma.enable = mkEnableOption "plasma";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = mkForce true;
    services.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
