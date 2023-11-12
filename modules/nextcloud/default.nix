{ pkgs, hostName,  ... }:
{
	environment.etc."nextcloud-admin-pass".text = "test123";
	#environment.systemPackages = with pkgs; [ openssl ];
	networking.firewall.allowedTCPPorts = [ 80 ];
	services.nextcloud = {
		enable = true;
		package = pkgs.nextcloud27;
		hostName = hostName;
		#https = true;
		config.adminpassFile = "/etc/nextcloud-admin-pass";
		extraApps = with config.services.nextcloud.package.packages.apps; {
			inherit news contacts calendar tasks;
		};
		extraAppsEnable = true;
	};
	services.nginx.enable = true;
	services.nginx.virtualHosts.${config.services.nextcloud.hostName}  = {
		#forceSSL = true;
		#enableACME = true;
		listen = [ 
			{ addr = "0.0.0.0"; port = 80; }		
		];
		locations."/" = {
			proxyPass = "https://localhost";
		};
	};
	#security.acme.acceptTerms = true;
}
