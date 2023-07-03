{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      ch03 = with pkgs.python3Packages;
        buildPythonPackage {
          pname = "YO";
          version = "0.0.0.1";
          src = ./03first-python-package;
          format = "pyproject";
          propagatedBuildInputs = [ setuptools ];
        };
    in {
      packages.${system}.default = ch03;

      devShells.${system} = with pkgs; {
        default = mkShell {
          buildInputs = [
            python311Packages.build
            python311Packages.tox
            pre-commit
            cookiecutter
          ];
        };
      };
    };
}
