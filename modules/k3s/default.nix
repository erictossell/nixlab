{ pkgs, ... }:
{
  services.k3s = {
    enable = true;
    role = "server";
    token = "myrandomizedtoken";
    clusterInit = true;
  };
  networking.firewall = {
    allowedTCPPorts = [ 6443 ];
    allowedUDPPorts = [ 8472 ];
  };
  environment.systemPackages = with pkgs; [
    k3s
  ];
}
