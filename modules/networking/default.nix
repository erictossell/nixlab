{ hostName, address, interface, ... }:
{
  imports = [
    ./tailscale.nix
  ];
  networking = {
    inherit hostName;
    useDHCP = false;
    interfaces.${interface}.ipv4.addresses = [{
      inherit address;
      prefixLength = 24;
    }];
    defaultGateway = {
      address = "192.168.3.1";
      inherit interface;
    };
  };
}
