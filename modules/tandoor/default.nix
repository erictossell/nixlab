{ address, ... }:
{
  services.tandoor-recipes = {
    enable = true;
    port = 3002;
    address = "127.0.0.1";
  };
  networking.firewall.allowedTCPPorts = [ 3002 ];
}
