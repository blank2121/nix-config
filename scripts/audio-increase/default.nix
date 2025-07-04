{ lib, pkgs, ...}:
pkgs.writers.writeBash "audio-increase" ''
    ${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%+
''
