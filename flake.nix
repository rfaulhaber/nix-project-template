{
  description = "Nix project template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    # for the unstable branch:
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    projectName = "nix-template";
    supportedSystems = [
      "x86_64-linux"
      # TODO add other systems as needed
    ];
    forSystems = systems: f:
      nixpkgs.lib.genAttrs systems
      (system: f system (import nixpkgs {inherit system;}));
    forAllSystems = forSystems supportedSystems;
  in {
    packages = forAllSystems (system: pkgs: {
      # TODO add derivation / builder
      ${projectName} = pkgs.hello;
      default = self.packages.${system}.${projectName};
    });

    apps = forAllSystems (system: pkgs: {
        # TODO add derivation / builder
      ${projectName} = {
        type = "app";
        program = self.packages.${system}.${projectName};
      };
      default = self.apps.${system}.${projectName};
    });

    templates.default = {
      path = ./.;
      description = "Generic Nix template.";
    };

    formatter = forAllSystems (system: pkgs: pkgs.alejandra);

    devShells = forAllSystems (system: pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # TODO add dev dependencies here
        ];
      };
    });
  };
}
