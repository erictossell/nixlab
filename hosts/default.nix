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

  system.stateVersion = "23.11";
}
