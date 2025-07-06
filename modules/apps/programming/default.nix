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
    imports = [
        ./configurable.nix
        ./editors.nix
        ./sh.nix
    ];

    options.my.apps.programming.enable = mkEnableOption "cli programs";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
          # configureless CLIS with home-manager
          home.packages = with pkgs; [
            # ntfy
            # ansel
            bacon
            bat
            btop
            btrfs-progs
            fd
            fzf
            gcc
            ghc
            glow
            gnumake
            gnupg
            gum
            haskellPackages.cabal-install
            haskellPackages.haskell-language-server
            haskellPackages.stack
            hplip
            jq
            julia
            # mark
            mprocs
            nix-output-monitor
            nmap
            nodejs_20
            openjdk openssl_3
            pandoc
            pango
            ripgrep-all
            texliveFull
            trash-cli
            vim
            wget
            which
            
            cargo
            clippy
            rustfmt
            rust-analyzer
            rustc
          ];
        };
    };
}
