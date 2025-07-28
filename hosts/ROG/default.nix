{ config, pkgs, inputs, username, ... }:
{

    imports = [ ../../modules ./hardware.nix ];

    # remove after rutgers
    # security.pki.certificateFiles = [ /home/winston/Downloads/usertrustrsacertificationauthority.cer ];

    my = {
        system = {
            bluetooth.enable = true;
            networking.enable = true;
            printing.enable = true;
            audio.enable = true;
        };   

        desktops = {
            login.ly.enable = true;
            niri.enable = true;
	        hyprland.enable = false;

            extras = {
                swaylock.enable = true;
                swaync.enable = true;
                waybar.enable = true;
                wlogout.enable = true;
                xremap.enable = true;
            };
        };

        apps = {
            # TODO: add the architipes below
            programming.enable = true;
            programming.copyparty = true;
            # gaming.enable = false;

            discord.enable = true;
            email.enable = true;
            godot.enable = true;
            krita.enable = true;
            libre.enable = true;
            mpv.enable = true;
            obsidian.enable = true;
            photo.enable = true;
            spotify.enable = true;
            terminal.enable = true;
            zen.enable = true;
            zoom.enable = true;
        };

        # info from flake.nix is enough to create user

        style.rose-pine.enable = true;
    };
}
