{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}: 

with lib;

let

alias = {
    bt = "bluetoothctl";
    nv = "${inputs.nixvim.packages.${pkgs.system}.code}/bin/nvim";
    wr = "${inputs.nixvim.packages.${pkgs.system}.writer}/bin/nvim";
    rm = "trash-put";
    cd = "z";
    wallpaper = "nix run ~/nix/machines/#random-wallpaper --impure ~/Pictures/wallpaper/";
    zj = "zellij";
    ls = "eza --icons=always";
};
extra = ''
    export EDITOR="nvim"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.julia/packages/LanguageServer/Fwm1f/src/LanguageServer.jl:$PATH"
    export NIXPKGS_ALLOW_INSECURE=1
    export NIXPKGS_ALLOW_BROKEN=1
    export STARSHIP_CONFIG=$HOME/nixcfg/dotfiles/starship.toml
    export NIXPKGS_ALLOW_UNFREE=1

    # starship + zoxide setup
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
    
    # carapace setup
    export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace)

    ${pkgs.nitch}/bin/nitch 
'';

cfg = config.my.apps.programming;

in
{
  config = mkIf cfg.enable {
      home-manager.users.${username}.programs.zsh = {
          enable = true;
          autocd = true;
          defaultKeymap = "viins";
          autosuggestion.enable = true;
          enableCompletion = true;
          shellAliases = alias;
          syntaxHighlighting.enable = true;
          envExtra = extra;
      };
  };
}
