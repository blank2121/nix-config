{ lib, config, options, pkgs, username, ... }:

with lib;

let 
    cfg = config.my.apps.programming.copyparty;
in {

    options.my.apps.programming.copyparty.enable = mkEnableOption "copyparty";

    config = mkIf cfg.enable {
        home-manager.users.${username}.home.packages = with pkgs; [ copyparty ];
        services.copyparty = {
            enable = true;
            settings = {

                default = {
                    hist = "/home/${username}/.cache/copyparty";
                };
                
                volumes = {
                    "/docs" = {
                        path = "/home/${username}/Documents/2025-2026";
                        access = {
                            rg = "*";
                        };
                    };

                    "/photos" = {
                        path = "/home/winston/photos";
                        access = {
                            rg = "*";
                        };
                    };
                };
            };
        };
    };
}
