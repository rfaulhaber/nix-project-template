{
  description = "Nix project template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    # for the unstable branch:
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {
            inherit system;
          };
          projectName = "nix-project-template";
      in {
        packages.default = self.packages.${system}.${projectName};

        apps.${projectName} = flake-utils.lib.mkApp {drv = self.packages.${projectName};};
        apps.default = self.apps.${system}.${projectName};

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # TODO add dev dependencies here
          ];
        };
      }
    );
}
