{ address, ... }:
{
  services.tandoor-recipes = {
    enable = true;
    port = 8081;
    inherit address;
  };
  networking.firewall.allowedTCPPorts = [ 8081 ];
}
