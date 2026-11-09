{
  description = "Personal project, working through Ising models, Boltzmann machines, and related subjects.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python314;
        pythonEnv = python.withPackages (
          ps: with ps; [
            numba
            pytest
            sympy
            numpy
            scipy
            matplotlib
          ]
        );

      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonEnv
            pkgs.pyrefly
          ];

          shellHook = ''
            echo "Python $(python --version)"
            echo "VSCodium $(codium --version 2>/dev/null | head -n1)"
          '';
        };
      }
    );
}
