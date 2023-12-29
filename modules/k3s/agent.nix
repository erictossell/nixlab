{ pkgs, ... }:
{
  services.k3s = {
    enable = true;
    role = "server";
    token = "myrandomizedtoken";
    serverAddr = "https://192.168.2.195:6443";
  };
  networking.firewall = {
    allowedTCPPorts = [ 6443 ];
    allowedUDPPorts = [ 8472 ];
  };
  environment.systemPackages = with pkgs; [
    k3s
  ];
}
