{ username, pkgs, ... }:

{
    users.users."${username}" = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
        ];
        shell = pkgs.zsh;
    };
    
    home-manager.users.${username} = {
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.05";

        programs.home-manager.enable = true;
    };
}
