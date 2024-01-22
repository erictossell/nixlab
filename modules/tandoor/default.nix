{ address, ... }:
{
  services.tandoor-recipes = {
    enable = true;
    port = 3002;
    address = address;
  };
  networking.firewall.allowedTCPPorts = [ 3002 ];
}
