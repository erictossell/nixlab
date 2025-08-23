{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostId = "4a98161d";
  networking.firewall.allowedTCPPorts = [ 8096 9090 3000 ];
}
