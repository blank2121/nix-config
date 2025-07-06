{ config, options, lib, pkgs, username, ... }:

with lib;

let
    vol-up = pkgs.callPackage ../../../../scripts/audio-increase {};
    vol-down = pkgs.callPackage ../../../../scripts/audio-decrease {};
    bright-up = pkgs.callPackage ../../../../scripts/brightness-increase {};
    bright-down = pkgs.callPackage ../../../../scripts/screenshot {};
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

        # services.xremap.userName = username;
        # services.xremap.config = {

        #     modmap = [
        #         {
        #             name = "vim escape";
        #             remap = { "CapsLock" = "Esc"; };
        #             application = { "only" = "kitty"; };
        #         }
        #     ];
        #
        #     keymap = [
        #         {
        #             name = "vol-up";
        #             remap."VolumeUp".launch = [ vol-up ];
        #         }
        #         {
        #             name = "vol-down";
        #             remap."VolumeDown".launch = [ vol-down ];
        #         }
        #         {
        #             name = "bright-up";
        #             remap."BrighnessUp".launch = [ bright-up ];
        #         }
        #         {
        #             name = "bright-down";
        #             remap."BrightnessDown".launch = [ bright-down ];
        #         }
        #     ];
        #
        # };
    };
}
