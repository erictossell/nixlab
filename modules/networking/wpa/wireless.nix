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
    inherit hostName;
    useDHCP = false;
    wireless = {
      enable = true;
      environmentFile = "/run/secrets/wireless.env";
      networks = { "@SSID@".psk = "@SSIDpass@"; };
    };
    interfaces.${interface}.ipv4.addresses = [{
      inherit address;
      prefixLength = 24;
    }];
    defaultGateway = {
      address = "192.168.2.1";
      inherit interface;
    };
    nameservers = [ "192.168.2.24" ];

  };

}   
