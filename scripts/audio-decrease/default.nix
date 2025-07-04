{ lib, pkgs, ...}:
pkgs.writers.writeBash "audio-decrease" ''
    ${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%-
''
