{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.firewall.allowedTCPPorts = [ 5006 ];
}
