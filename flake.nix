{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
        let
            pkgs = import nixpkgs { inherit system; };
            django-htmlmin = pkgs.python3Packages.buildPythonPackage rec {
                pname = "django-htmlmin";
                version = "0.11.0";
                format = "setuptools";

                src = pkgs.python3Packages.fetchPypi {
                    inherit pname version;
                    sha256 = "sha256-5BsqIVdXCEZkXMY2qb3d6Ko+A/aDSpIR5hoX8u1CuH4=";
                };
                propagatedBuildInputs = with pkgs.python3Packages; [
                    beautifulsoup4
                    html5lib
                    mock
                    six
                ];
            };
        in {
            devShells.default = pkgs.mkShell {
                name = "zig-devshell";
                packages = with pkgs; [
                    (python3.withPackages (python-pkgs: [
                       django-htmlmin
                       python-pkgs.django_4
                       python-pkgs.requests
                       python-pkgs.scipy
                    ]))
                ];
            };
        }
    );
}
