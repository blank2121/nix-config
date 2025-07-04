{ lib, config, options, pkgs, ... }:

with lib;

let
    cfg = config.my.system.audio;
in {

    options.my.system.audio = {
        enable = mkEnableOption "audio";
    };

    config = mkIf cfg.enable {
        # Enable audio
        services = {
          pipewire = {
            enable = true;
            audio.enable = true;
            pulse.enable = true;
            alsa = {
              enable = true;
              support32Bit = true;
            };
            jack.enable = true;
          };
        };

        environment.systemPackages = with pkgs; [
            alsa-utils
        ];
    };
}
