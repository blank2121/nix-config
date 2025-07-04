{
    description = "the configuration of my machines.";

    outputs = inputs: with inputs; let
        pkgs = system: import nixpkgs {
                inherit system;
                config = { 
                    allowUnfree = true; allowBroken = true; allowUnsupportedSystem = true;
                };
                nix.package = pkgs.nixVersions.unstable;
                nix.settings.experimental-features = "nix-command flakes";
                overlays = [
                    niri.overlays.niri polymc.overlay
                ];
            };
    in { 
        nixosConfigurations = {
            ROG = nixpkgs.lib.nixosSystem {
                pkgs = (pkgs "x86_64-linux");
                specialArgs = { inherit inputs; 
                                username = "winston"; 
                                hostname = "ROG"; };

                modules = [
                    ./hosts/ROG
                    niri.nixosModules.niri
                    nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
                    stylix.nixosModules.stylix
                    home-manager.nixosModules.home-manager {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager = { backupFileExtension = "backup"; };
                    }
                ];
            };
        };

    # ignore this bottom part, this just adds in all scrips so they can be used.
    } // (pkgs "x86_64-linux").callPackage ./utils/app-maker.nix { folder = ./scripts; };


    inputs = {
        determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        niri.url = "github:sodiboo/niri-flake";
        nixos-hardware.url = "github:Nixos/nixos-hardware/master";
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        nixvim.url = "github:blank2121/nixvim";
        polymc.url = "github:PolyMC/PolyMC";
        stylix.url = "github:danth/stylix";
        zen-browser.url = "github:0xc000022070/zen-browser-flake";
    };
}
