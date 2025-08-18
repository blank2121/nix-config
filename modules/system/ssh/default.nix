{ pkgs, lib, config, options, ... }:

with lib;

let
    cfg = config.my.system.ssh;
in {
    options.my.system.ssh = {
        enable = mkEnableOption "ssh";
    };

    config = mkIf cfg.enable {
      services.openssh = {
          enable = true;
          ports = [ 22 ];
          settings = {
            PasswordAuthentication = true;
            AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
          };
        };  
    };
}
