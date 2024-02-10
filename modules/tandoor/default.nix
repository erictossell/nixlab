{ address, ... }:
{
  services.tandoor-recipes = {
    enable = true;
    port = 8081;
    address = address;
  };
  networking.firewall.allowedTCPPorts = [ 8081 ];
}
