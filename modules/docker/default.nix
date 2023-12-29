{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [ docker-compose ];

  # Docker can also be run rootless
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune = {
    	enable = true;
	dates = [ "weekly" ];
	keep = 3;
    };
    extraOptions = ''
      # Add extra options here
    '';
  };
  # User permissions 
  users.users.${user}.extraGroups = [ "docker" ];

}
