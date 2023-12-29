{ hostName, address, interface, ... }:
{
  imports = [
    ./tailscale.nix
  ];

  age.secrets."wireless.env" = {
	file = ../../secrets/wireless.age;
	path = "/run/secrets/wireless.env";
  };

  networking = {
	hostName = hostName;
	useDHCP = false;
	wireless = {
		enable = true;
		environmentFile = "/run/secrets/wireless.env";
		networks = { "@SSID@".psk = "@SSIDpass@"; };
	};
	interfaces.${interface}.ipv4.addresses = [{
		address = address;
		prefixLength = 24;
	}];
	defaultGateway = {
		address = "192.168.2.1";
		interface = interface;
	};
	nameservers = [ "8.8.8.8" "8.8.4.4" ];

	# Enable ports for Docker Swarm
	firewall.allowedTCPPorts = [ 2377 7946 ];
	firewall.allowedUDPPorts = [ 4789 7946 ];
  };

}
