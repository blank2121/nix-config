{ 
    inputs,
    lib,
    pkgs,
    config,
    username,
    ...
}: 

with lib;

let
    cfg = config.my.apps.programming;
in {
    config = mkIf cfg.enable {
        home-manager.users.${username} = {
          # helix config
          programs.helix = {
              enable = true; 
              package = pkgs.evil-helix;
              settings = {
                  editor = {
                      line-number = "relative";
                      evil = "true";
                  };
                  keys.normal = {
                      space.space = "file_picker";
                      space.w = ":w";
                      space.q = ":q";
                      esc = [
                          "collapse_selection"
                          "keep_primary_selection"
                      ];
                  };
              };
              extraPackages = with pkgs; [
                  rust-analyzer
                  marksman
              ];
          };

          # yazi config      
          programs.yazi = {
            enable = true; 
            enableZshIntegration = true;
            keymap = {
              manager = {
                prepend_keymap = [
                  {
                     desc = "Set hovered file as wallpaper";
                     on = [ "b" "g" ];
                     run = "shell --confirm \"swww img --transition-type=any $0\"";
                  }
                ];
              };
            };
          };
        }; 

        # nixvim config
        environment.systemPackages = [
            inputs.nixvim.packages.${pkgs.system}.code
            inputs.nixvim.packages.${pkgs.system}.writer
        ];
    };
}
