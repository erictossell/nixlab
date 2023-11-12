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

      nixboard = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
          specialArgs = {
            user = "eriim";
            hostName = "nixboard";
            address = "10.0.0.196";
            interface = "wlan0";
        } // attrs;
        modules = [       
          ./.
          ./modules/rpi
          ./modules/rpi/4
          ./modules/postgres
        ];
      };#nixboard

      nixbox = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          user = "eriim";
          hostName = "nixbox";
          address = "10.0.0.195";
          interface = "wlan0";
        } // attrs ;
        modules = [
          ./.       
          ./modules/rpi
          ./modules/rpi/4
          ./modules/samba-server
        ];
      };#nixbox

      nixcube = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          user = "eriim";
          hostName = "nixcube";
          address = "10.0.0.197";
          interface = "wlan0";
        } // attrs;
        modules = [       
          ./.
          ./modules/rpi
          ./modules/rpi/3      
        ];
      };#nixcube
  
      nixtop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          user = "eriim";
          hostName = "nixboard";
          address = "10.0.0.190";
          interface = "wlp63s0";
        } // attrs;
        modules = [       
          ./.
          ./x86_64
        ];
      };#nixtop

    };#configs
  };#outputs
}#flake
