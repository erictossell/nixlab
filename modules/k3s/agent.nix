{ pkgs, ... }:
{
  services.k3s = {
    enable = true;
    role = "server";
    token = "myrandomizedtoken";
    serverAddr = "https://192.168.2.195:6443";
  };
  networking.firewall = {
    allowedTCPPorts = [ 2379 2380 6443 10250 ];
    allowedUDPPorts = [ 8472 51820 51821 ];
  };
  environment.systemPackages = with pkgs; [
    k3s
  ];
}
