{ config, hostName, ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
	http_port = 3001;
        domain = "${hostName}";
	root_url = "http://${hostName}/grafana/"; 
	serve_from_sub_path = true;
      };
    };
  };
  services.nginx.virtualHosts.${hostName} = {
  addSSL = true;
  enableACME = true;
  locations."/grafana/" = {
      proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
  };
};

}
