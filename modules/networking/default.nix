{ hostName, address, interface, ... }:
{
  imports = [
    #./tailscale.nix
  ];
  networking = {
    inherit hostName;
    useDHCP = false;
    interfaces.${interface}.ipv4.addresses = [{
      inherit address;
      prefixLength = 24;
    }];
    defaultGateway = {
      address = "192.168.2.1";
      inherit interface;
    };
    nameservers = [ "192.168.2.2" "192.168.2.3" ];
  };
}
