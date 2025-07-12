{ config, options, lib, pkgs, username, ... }:

with lib;

let
    vol-up = pkgs.callPackage ../../../../scripts/audio-increase {};
    vol-down = pkgs.callPackage ../../../../scripts/audio-decrease {};
    bright-up = pkgs.callPackage ../../../../scripts/brightness-increase {};
    bright-down = pkgs.callPackage ../../../../scripts/brightness-decrease {};
    screenshot = pkgs.callPackage ../../../../scripts/screenshot {};
    cfg = config.my.desktops.extras.xremap;
in {
    options.my.desktops.extras.xremap.enable = mkEnableOption "xremap";

    config = mkIf cfg.enable {
        hardware.uinput.enable = true;
        users.groups.input.members = [ username ];
        users.groups.uinput.members = [ username ];

        environment.systemPackages = with pkgs; [
            xremap
        ];

        home-manager.users.${username} = {
            home.file.".config/xremap/config.yaml" = {
                enable = true;
                text = ''
                    modmap:
                      - name: cap-esc
                        application:
                          only: kitty
                        remap:
                          CapsLock:
                            held: leftctrl
                            alone: esc
                            alone_timeout_millis: 150

                    keymap:
                      - name: volume and brightness and screenshot
                        remap:
                          VolumeUp: 
                            launch: ["${vol-up}"]
                          VolumeDown: 
                            launch: ["${vol-down}"]
                          F8: 
                            launch: ["${bright-up}"]
                          F7: 
                            launch: ["${bright-down}"]
                          F6:
                            launch: ["${screenshot}"]
                '';
            };
        };

    };
}
