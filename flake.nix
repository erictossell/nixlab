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
<<<<<<< HEAD
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
	  ./modules/docker
	  ./modules/k3s
	  ./modules/k3s/rpi.nix
        ];
      };#nixbox
=======
    nixosConfigurations.nixbox = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        user = "eriim";
        hostName = "nixbox";
        address = "10.0.0.195";
        SSID = "Rogers13";
        SSIDpass = "Summertime4U!";
        interface = "wlan0";
      } // attrs ;
      modules = [
            ./.       
            ./modules/rpi4_core
            ./modules/samba-server
            ./modules/nextcloud            
      ];
    }; #nixbox

    nixosConfigurations.nixboard = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        user = "eriim";
        hostName = "nixboard";
        address = "10.0.0.196";
        SSID = "Rogers13";
        SSIDpass = "Summertime4U!";
        interface = "wlan0";
      } // attrs;
      modules = [       
            ./.
            ./modules/rpi4_core
            ./modules/postgres
      ];
    }; #nixboard
    
    nixosConfigurations.nixcube = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        user = "eriim";
        hostName = "nixcube";
        address = "10.0.0.197";
        SSID = "Rogers13";
        SSIDpass = "Summertime4U!";
        interface = "wlan0";
      } // attrs;
      modules = [       
            ./.
            ./modules/rpi3_core      
      ];
    }; #nixcube
>>>>>>> 241a050 (russh config.json)

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
          ./modules/k3s/agent.nix
	  ./modules/k3s/rpi.nix
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
	  ./modules/docker
          ./modules/k3s/agent.nix
	  ./modules/k3s/rpi.nix
        ];
      };#nixcube

      live-image = 
      let system = "aarch64-linux";
      in nixpkgs.lib.nixosSystem {
        system = system;
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
      };#live-image

    };#configs

    templates.default = {
	path = ./.;
	description = "A NixOS Flake for raspberry pi devices";
    };#templates

  };#outputs
}#flake
