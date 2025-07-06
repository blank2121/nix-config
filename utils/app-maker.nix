{ lib, pkgs, folder, systems ? [ "x86_64-linux" "aarch64-darwin" "aarch64-linux" "x86_64-darwin" ] }:

let
  # Get only directory entries
  entries = builtins.attrNames (builtins.readDir folder);

  packageDirs = builtins.filter
    (name: (builtins.readFileType (folder + "/${name}") == "directory"))
    entries;

  # Build a set like { system = { name = pkg; ... }; }
  perSystemPackages = lib.genAttrs systems (system:
    let
      pkgsForSystem = import pkgs.path { inherit system; };
    in
      lib.genAttrs packageDirs (name:
        pkgsForSystem.callPackage (folder + "/${name}") {}
      )
  );

  # Build apps per system using the above packages
  perSystemApps = lib.mapAttrs (_system: pkgsForSys:
    lib.genAttrs (builtins.attrNames pkgsForSys) (name: {
      type = "app";
      program = "${pkgsForSys.${name}}";
    })
  ) perSystemPackages;
  
  # --- formatter ---
  forAllSystems = lib.genAttrs systems;

  formatter = forAllSystems (
    system: let
        pkgs = (import <nixpkgs> {}).legacyPackages.${system};
    in
        pkgs.alejandra
  );

in {
  inherit formatter;
  packages = perSystemPackages;
  apps = perSystemApps;
}
