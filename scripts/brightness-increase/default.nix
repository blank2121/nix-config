{ lib, pkgs, ...}:
pkgs.writers.writeBash "brightness-increase" ''
    ${pkgs.brightnessctl}/bin/brightnessctl set 1%+
''
