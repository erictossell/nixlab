{ pkgs, hostName, user, ... }:
{
  imports = [
    ./${hostName}
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ user ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop
    vim
  ];
  
  security.sudo.wheelNeedsPassword = false;

  security.sudo.extraConfig = ''
eriim ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild switch --flake 'github:erictossell/nix-pi-lab'
'';


  system.stateVersion = "23.11";
}
