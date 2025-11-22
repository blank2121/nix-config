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
        ./copyparty
        ./editors.nix
        ./sh.nix
    ];

    options.my.apps.programming.enable = mkEnableOption "cli programs";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
          # configureless CLIS with home-manager
          home.packages = with pkgs; [
            bacon
            bat
            btop
            btrfs-progs
            du-dust
            dua
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
            typst
            typst-live
            vim
            wget
            which
            
            cargo
            clippy
            rustfmt
            rust-analyzer
            rustc

            # lsp servers
            nil
            svelte-language-server
            vscode
            superhtml
            vscode-css-languageserver
            typescript-language-server
          ];
        };
    };
}
