{ config, pkgs, lib, agenix, user, ... }:
let
  corePackages = import pkgs/core.nix { inherit pkgs; };
in 
{	
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ user ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = corePackages;
  system.stateVersion = "23.11";  
}
