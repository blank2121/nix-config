{ config, pkgs, inputs, username, ... }:
{

    imports = [ ../../modules ./hardware.nix ];
    
    my = {
        system = {
            bluetooth.enable = true;
            networking.enable = true;
            printing.enable = true;
            audio.enable = true;
            ssh.enable = true;
        };   

        desktops = {
	        # login.ly.enable = false;
	        # niri.enable = false;
	        # hyprland.enable = false;

            plasma.enable = true;

            # extras = {
            #     swaylock.enable = false;
            #     swaync.enable = false;
            #     waybar.enable = false;
            #     wlogout.enable = false;
            #     xremap.enable = false;
            # };
        };

        apps = {
            programming.enable = true;
            programming.copyparty.enable = false;

            gaming = {
                minecraft.enable = true;
                hsr.enable = true;
                steam.enable = true;
            };

            discord.enable = true;
            email.enable = false;
            godot.enable = false;
            krita.enable = true;
            libre.enable = false;
            mpv.enable = true;
            obsidian.enable = false;
            photo.enable = false;
            spotify.enable = true;
            terminal.enable = true;
            zen.enable = true;
            zoom.enable = false;
        };

        # info from flake.nix is enough to create user

        style.rose-pine.enable = true;
    };
}
