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

          # jujutsu
          programs.jujutsu.enable = true;
          home.packages = with pkgs; [ jjui jj-fzf ];

          # zellij
          programs.zellij = {
            enable = true;
            enableZshIntegration = true;
          };
          home.file = {
            ".config/zellij/" = {
                recursive = true;
                source = builtins.toString ./zellij-files;
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
