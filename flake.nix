{
  description = "A build environment for Constellation Cards";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    napalm.url = "github:nix-community/napalm";
  };

  outputs = { self, nixpkgs, flake-utils, napalm, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cruxNode = napalm.legacyPackages."${system}".buildPackage ./. {
          nodejs = pkgs.nodejs_22;
        };
      in
      {
        packages.default = pkgs.dockerTools.buildLayeredImage {
          name = "crux";
          tag = "latest";
          contents = [
            pkgs.bash
            pkgs.busybox
            pkgs.texliveConTeXt
            pkgs.nodejs_22
            pkgs.imagemagick
            cruxNode
          ];
          config = {
            Cmd = ["/bin/bash" "build.sh"];
            WorkingDir = "/_napalm-install";
          };
        };
        devShell = pkgs.mkShell {
          name = "crux";
          packages = [
            pkgs.texliveConTeXt
            pkgs.nodejs_22
            pkgs.imagemagick
          ];
        };
      }
    );
}
