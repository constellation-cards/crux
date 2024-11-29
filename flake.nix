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
#           pkgs.ghostscript
#           pkgs.imagemagick
            pkgs.nodejs_22
#           pkgs.parallel
            pkgs.texliveConTeXt
            cruxNode
          ];
          config = {
            Cmd = ["/bin/bash" "build.sh"];
            WorkingDir = "/_napalm-install";
            Labels = {
              "org.opencontainers.image.source" = "https://github.com/constellation-cards/crux";
              "org.opencontainers.image.description" = "Builds PDFs and images from Constellation Cards JSON data";
            };
          };
        };
        devShell = pkgs.mkShell {
          name = "crux";
          packages = [
#           pkgs.ghostscript
#           pkgs.imagemagick
            pkgs.nodejs_22
#           pkgs.parallel
            pkgs.texliveConTeXt
          ];
        };
      }
    );
}
