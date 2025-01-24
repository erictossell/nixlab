{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.firewall.allowedTCPPorts = [ 3104 4533 5006 8443 2222 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
}
