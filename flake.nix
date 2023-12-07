{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };#agenix

  };

  outputs = { self, nixpkgs, agenix, ... } @ attrs:{
    nixosConfigurations = { 

      nixbox =
      let system = "aarch64-linux";
      in nixpkgs.lib.nixosSystem {
        specialArgs = {
          user = "eriim";
          hostName = "nixbox";
          address = "192.168.2.195";
          interface = "wlan0";
          inherit system;
	} // attrs ;
        modules = [
          ./.
          ./modules/rpi/4
          ./modules/samba-server
	  ./modules/podman
        ];
      };#nixbox

      nixboard =
      let system = "aarch64-linux";
      in nixpkgs.lib.nixosSystem {
        specialArgs = {
	  user = "eriim";
          hostName = "nixboard";
          address = "192.168.2.196";
          interface = "wlan0";
	  inherit system;
        } // attrs;
        modules = [       
          ./.
          ./modules/rpi/4
	  ./modules/docker
        ];
      };#nixboard

      nixcube = 
      let system = "aarch64-linux";
      in nixpkgs.lib.nixosSystem {
        specialArgs = {
          user = "eriim";
          hostName = "nixcube";
          address = "192.168.2.197";
          interface = "wlan0";
          inherit system;
	} // attrs;
        modules = [       
          ./.
          ./modules/rpi/3      
	  ./modules/monitoring
        ];
      };#nixcube

    };#configs

    templates.default = {
	path = ./.;
	description = "A NixOS Flake for raspberry pi devices";
    };#templates

  };#outputs
}#flake
