{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };

  outputs = { self, nixpkgs, agenix, ... } @ attrs:{
    nixosConfigurations = { 
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
              ./modules/rpi4_core
              ./modules/samba-server
              ./modules/nextcloud            
        ];
      }; #nixbox

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
            ./modules/rpi4_core
            ./modules/postgres
        ];
      }; #nixboard
    
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
            ./modules/rpi3_core      
        ];
      }; #nixcube

    };#configs
  };#outputs
}#flake
