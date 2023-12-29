{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [ docker-compose ];

  # Docker can also be run rootless
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune = {
    	enable = true;
	dates =  "weekly" ;
    };
    extraOptions = ''
      # Add extra options here
    '';
  };
  # User permissions 
  users.users.${user}.extraGroups = [ "docker" ];

  # Enable ports for Docker Swarm
  #networking.firewall= {
  #  allowedTCPPorts = [ 2377 7946 ];
  #  allowedUDPPorts = [ 4789 7946 ];
  #};
}
