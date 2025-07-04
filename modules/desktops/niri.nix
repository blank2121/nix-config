{
  config,
  lib,
  pkgs,
  username,
  ...
}:

with lib;

let
    vol-up = pkgs.callPackage ../../scripts/audio-increase {};
    vol-down = pkgs.callPackage ../../scripts/audio-decrease {};
    bright-up = pkgs.callPackage ../../scripts/brightness-increase {};
    bright-down = pkgs.callPackage ../../scripts/brightness-decrease {};
    screenshot = pkgs.callPackage ../../scripts/screenshot {};
    cfg = config.my.desktops.niri;
in {
  options = {
    my.desktops.niri.enable = lib.mkEnableOption "niri";
  };

  config = mkIf cfg.enable {

      environment.systemPackages = with pkgs; [
          cage
          swww
          wayland-utils
          wl-clipboard
          xwayland-satellite-unstable
      ];

# enable niri
      systemd.user.services.niri-flake-polkit.enable = false;
      programs.niri.enable = true;

      home-manager.users.${username} = {
          
          services.swww.enable = true;

          programs.niri = {
              package = pkgs.niri-stable;
              settings = {
                  environment."NIXOS_OZONE_WL" = "1";
                  outputs."eDP-1".scale = 1.5;
                  spawn-at-startup = [
                    { command = [ "${pkgs.kitty}/bin/kitty" ]; }
                  ];
                  input = {
                      keyboard.xkb = {
                          layout = "us,es";
                          options = "grp:win_space_toggle";
                      };
                      touchpad = {
                        # accel-profile = "adaptive";
                        # accel-speed = 0;
                          click-method = "clickfinger";
                          natural-scroll = true;
                          scroll-method = "two-finger";
                          scroll-factor = 0.15;
                          tap = true;
                          dwt = true;
                      };
                  };
                  layout = {
                      gaps = 16;
                      center-focused-column = "never";
                      preset-column-widths = [
                      { proportion = 1.0 / 3.0; }
                      { proportion = 1.0 / 2.0; }
                      { proportion = 1.0; }
                      ];
                      default-column-width = {
                          proportion = 1.0 / 2.0;
                      };
                      focus-ring = {
                          width = 4;
                      };
                      struts = {
                          left = 48;
                          right = 48;
                          bottom = 32;
                          top = 32;
                      };
                  };
                  binds =
                      with home-manager.users.${username}.lib.niri.actions;
                  let
                      mod = "Alt";
                  in
                  {
                        # TODO: remove and add to sxhkd
                      "XF86AudioRaiseVolume".action = spawn "${vol-up}/bin/audio-increase";
                      "XF86AudioLowerVolume".action = spawn "${vol-down}/bin/audio-decrease";
                      "XF86MonBrightnessUp".action = spawn "${bright-up}/bin/brightness-increase";
                      "XF86MonBrightnessDown".action = spawn "${bright-down}/bin/brightness-decrease";

                      "${mod}+F".action = fullscreen-window;
                      "${mod}+M".action = spawn "${pkgs.swaynotificationcenter}/bin/swaync-client" "-t";
                      "${mod}+Return".action = spawn "${pkgs.kitty}/bin/kitty";
                      "${mod}+Shift+E".action = spawn "${pkgs.wlogout}/bin/wlogout";
                      "${mod}+Shift+Q".action = close-window;
                      "${mod}+Space".action = spawn "${pkgs.wofi}/bin/wofi" "--show" "drun" "-Ibm" "-W" "576";
                      "${mod}+V".action = toggle-window-floating;
                      "Ctrl+Shift+P".action = spawn "${pkgs.wofi-pass}/bin/wofi-pass";
                      "Ctrl+Shift+S".action = spawn "${screenshot}/bin/screenshot";

# movement
                      "${mod}+H".action = focus-column-left;
                      "${mod}+L".action = focus-column-right;
                      "${mod}+K".action = focus-window-or-workspace-up;
                      "${mod}+J".action = focus-window-or-workspace-down;

# window manipulation
                      "${mod}+Shift+H".action = move-column-left;
                      "${mod}+Shift+L".action = move-column-right;
                      "${mod}+Shift+K".action = move-window-up-or-to-workspace-up;
                      "${mod}+Shift+J".action = move-window-down-or-to-workspace-down;

                      "${mod}+Minus".action = set-column-width "-10%";
                      "${mod}+Equal".action = set-column-width "+10%";

                      "${mod}+Shift+Minus".action = set-window-height "-10%";
                      "${mod}+Shift+Equal".action = set-window-height "+10%";

                      "${mod}+A".action = consume-window-into-column;
                      "${mod}+R".action = expel-window-from-column;
                      "${mod}+S".action = switch-preset-column-width;

# workspaces
                      "${mod}+1".action = focus-workspace 1;
                      "${mod}+2".action = focus-workspace 2;
                      "${mod}+3".action = focus-workspace 3;
                      "${mod}+4".action = focus-workspace 4;
                      "${mod}+5".action = focus-workspace 5;
                      "${mod}+6".action = focus-workspace 6;
                      "${mod}+7".action = focus-workspace 7;
                      "${mod}+8".action = focus-workspace 8;
                      "${mod}+9".action = focus-workspace 9;

                      "${mod}+Shift+1".action = move-column-to-workspace 1;
                      "${mod}+Shift+2".action = move-column-to-workspace 2;
                      "${mod}+Shift+3".action = move-column-to-workspace 3;
                      "${mod}+Shift+4".action = move-column-to-workspace 4;
                      "${mod}+Shift+5".action = move-column-to-workspace 5;
                      "${mod}+Shift+6".action = move-column-to-workspace 6;
                      "${mod}+Shift+7".action = move-column-to-workspace 7;
                      "${mod}+Shift+8".action = move-column-to-workspace 8;
                      "${mod}+Shift+9".action = move-column-to-workspace 9;
                  };
              };
          };
      };
  };
}
