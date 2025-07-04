{
    config,
    options,
    lib,
    pkgs,
    username,
    ...
}:

with lib;

let
    cfg = config.my.apps.programming;
in {
    config = mkIf cfg.enable {
        home-manager.users.${username} = {
          # git
          programs.git = {
            enable = true;
            userEmail = "winstonwalter07@gmail.com";
            userName = "blank2121";
          };
          programs.lazygit.enable = true;

          # gpg
          # TODO: add to encryption section
          # services.gpg-agent = {
          #   enable = true;
          #   pinentryPackage = pkgs.pinentry-curses;
          #   enableExtraSocket = true;
          #   enableSshSupport = true;
          # };
          #
          # programs.gpg = {
          #   enable = true;
          #   publicKeys = [
          #     {
          #       source = "/home/${username}/nixcfg/gpg-key/subkey.pub";
          #       trust = 5;
          #     }
          #   ];
          # };

          # pass-store
          home.packages = [ pkgs.pass ];
          programs.password-store.enable = true; 

          # zellij
          # TODO: fix this for zellij config
          programs.zellij = {
            enable = true;
            enableZshIntegration = true;
          };
          home.file = {
            ".config/zellij/" = {
                recursive = true;
                source = "/home/${username}/nix/nixcfg/dotfiles/zellij";
            };
          };

          # other general clis
          programs = {
            eza = {
              enable = true;
              icons = "auto";
              enableZshIntegration = true;
            };

            fzf = {
              enable = true;
              enableZshIntegration = false;
            };

            ripgrep.enable = true;
            starship = {
              enable = true;
              enableZshIntegration = true;
            };

            zoxide = {
              enable = true;
              enableZshIntegration = true;
            };
          };
        };
    };
}
