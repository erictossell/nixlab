{ config, hostName, address, ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "${address}";
        http_port = 3001;
        domain = "${hostName}";
        root_url = "https://${hostName}/grafana/";
        serve_from_sub_path = true;
      };
    };
  };
  services.nginx.virtualHosts."${hostName}" = {
    enableACME = false;
    forceSSL = true;
    sslCertificate = "/srv/grafana/cert.pem";
    sslCertificateKey = "/srv/grafana/key.pem";
    locations."/grafana/" = {
      proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

}
