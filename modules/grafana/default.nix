{ config, ... }:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
	http_port = 3001;
        #domain = "graf.local";
	#root_url = "https://graf.local/grafana/"; 
	#serve_from_sub_path = true;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 3001 ];

}
