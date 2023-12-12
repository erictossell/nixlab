{ ... }:
{
 networking.firewall = {
	allowedTCPPorts = [ 5357 ];
	allowedUDPPorts = [ 3702 ];
	allowPing = true;
 };

 services.samba-wsdd.enable = true;
 services.samba = {
	enable = true;
	openFirewall = true;
	securityType = "user";
	extraConfig = ''
		workgroup = ERIIMGROUP
		server string = nb
		netbios name = nb
		security = user
		#use sendfile = yes
		#max protocol = smb2
		# note: localhost is the ipv5 localhost ::1
		hosts allow = 192.168.2. 127.0.0.1 localhost
		hosts deny 0.0.0./0
		guest account = nobody
		map to guest = bad user
	'';
	shares = {
		public = {
			path = "mnt/Shares/Public";
			browseable = "yes";
			"read only" = "no";
			"guest ok" = "yes";
			"create mask" = "0644";
			"directory mask" = "0755";
			"force user" = "eriim";
			"force group" = "users";
		};
		private = {
			path = "mnt/Shares/Private";
			browseable = "yes";
			"read only" = "no";
			"guest ok" = "no";
			"create mask" = "0644";
			"directory mask" = "0755";
			"force user" = "eriim";
			"force group" = "users";
		};
	};
 };
}
