{ lib, pkgs, ...}:
pkgs.writers.writeBash "brightness-decrease" ''
    ${pkgs.brightnessctl}/bin/brightnessctl set 1%-
''
