{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    }; #agenix

  };

  outputs = { self, nixpkgs, agenix, ... } @ attrs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {

      nixosConfigurations = {

        nixbox =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              user = "eriim";
              hostName = "nixbox";
              address = "192.168.2.3";
              interface = "end0";
              inherit system;
            } // attrs;
            modules = [
              ./.
              ./modules/rpi/4
              ./modules/samba-server
              ./modules/docker
              ./modules/tandoor
            ];
          }; #nixbox

        nixcube =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              user = "eriim";
              hostName = "nixcube";
              address = "192.168.2.4";
              interface = "enu1u1";
              inherit system;
            } // attrs;
            modules = [
              ./.
              ./modules/rpi/3
              ./modules/docker
            ];
          }; #nixcube

        nixboard =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              user = "eriim";
              hostName = "nixboard";
              address = "192.168.2.7";
              interface = "wlan0";
              inherit system;
            } // attrs;
            modules = [
              ./.
              ./modules/rpi/4
              ./modules/docker
              ./modules/grafana
              ./modules/nginx
              ./modules/tandoor
            ];
          }; #nixboard

        terminus =
          let system = "x86_64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              hostName = "terminus";
              user = "root";
              inherit system;
            } // attrs;
            modules = [
              ./hosts
              ./modules/aws
              ./users/root.nix
            ];
          }; #nixcube

        live-image =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              user = "nixos";
              hostName = "live-image";
              interface = "wlan0";
              inherit system;
            } // attrs;
            modules = [
              ./hosts
              ./users
              ./modules/ssh
            ];
          }; #live-image

      }; #configs

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ python3 statix ];
          };
        });

      templates.default = {
        path = ./.;
        description = "A NixOS Flake for raspberry pi devices running docker or podman.";
      }; #templates

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    }; #outputs
}#flake
