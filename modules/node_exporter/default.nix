{ config, pkgs, ... }:
{
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    enabledCollectors = [ "systemd" ];
    extraFlags = [ "--collector.ethtool" "--collector.softirqs" "--collector.tcpstat" ];
  };
  networking.firewall.extraCommands = ''
    iptables -A INPUT -p tcp --dport 9100 -s 192.168.2.15 -j ACCEPT
    iptables -A INPUT -p tcp --dport 9100 -j DROP
  '';
}
