{ lib, pkgs, config, options, ... }:

with lib;

let
    cfg = config.my.apps.gaming.hsr;
    aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
in {

    imports = [
      aagl-gtk-on-nix.module
    ];
    options.my.apps.gaming.hsr.enable = mkEnableOption "hsr";

    config = mkIf cfg.enable {
      programs.honkers-railway-launcher.enable = true;
    };
}
