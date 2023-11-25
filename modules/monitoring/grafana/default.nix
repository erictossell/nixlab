{ config, ... }:
{
  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "10.0.0.197";
      http_port = 3000;
      domain = "nixcube.et";
    };

    provision = {
      enable = true;
      datasources.settings.datasources = [
	{
          name = "prometheus nixcube";
	  type = "prometheus";
	  url = "http://127.0.0.1:${toString config.services.prometheus.exporters.node.port}";
	}
      ];
    };

  };
}
