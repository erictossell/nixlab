{ pkgs, ... }:
{
  services.prometheus = {
    enable = true;
    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
    };
  };
}
