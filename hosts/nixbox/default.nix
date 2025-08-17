{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.firewall.allowedTCPPorts = [ 53 5380 3104 4533 5006 8443 2222 22 ];
  networking.firewall.allowedUDPPorts = [ 22 53 ];
}
