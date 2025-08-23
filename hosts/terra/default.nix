{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostId = "4a98161d";
  networking.firewall.allowedTCPPorts = [ 8096 9090 3000 ];
  networking.firewall.extraCommands = ''
          iptables -A INPUT -p tcp --dport 9100 -s 172.17.0.0/16 -j ACCEPT
  '';
}
