{
  description = "Pegasus Frontend";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.pegasus-frontend = {
    url = "https://github.com/mbish/pegasus-frontend.git";
    flake = false;
    type = "git";
    submodules = true;
  };

  outputs = { self, nixpkgs, flake-utils, pegasus-frontend }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages =
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
            ];
          };
        in
        rec {
          default = pkgs.stdenv.mkDerivation rec {
            name = "pegasus-frontend";
            src = pegasus-frontend;

            buildInputs = [
              pkgs.cmake
              pkgs.SDL2
              pkgs.qt5.qtbase
              pkgs.qt5.qtsvg
              pkgs.qt5.qtgamepad
              pkgs.clang
              pkgs.qt5.qmake
              pkgs.qt5.qtmultimedia
              pkgs.qt5.qttools
              pkgs.qt5.wrapQtAppsHook
              pkgs.qt5.qtgraphicaleffects
            ];
            nativeBuildInputs = [
              pkgs.qt5.wrapQtAppsHook
              (pkgs.writeShellScriptBin "git" ''
                echo "${pegasus-frontend.rev or "dirty"}"
              '')
            ];

            configurePhase = ''
              mkdir build-dir
              cd build-dir && cmake ../
            '';

            buildPhase = ''
              make
            '';

            installPhase = ''
              mkdir -p $out/bin
              mv src/app/pegasus-fe $out/bin
            '';
          };
        };
    });
}
