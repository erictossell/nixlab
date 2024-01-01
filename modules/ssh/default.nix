<<<<<<< HEAD
{ user, ... }:
{
=======
{ config, pkgs, user, ... }:
{
    age.secrets.sshKey = {
	file = ../../secrets/eriimSSHKey.age;
	path="/home/${user}/.ssh/id_ed25519";
	owner=user;
	group="users";
        mode= "600";
  };
    
>>>>>>> 241a050 (russh config.json)
  users.users.${user} = {
	openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAETSTzRnvYIQsOwhdwcbVRyZVnP6/F3b+inurb9+RMu ${user}" ];
  };
  
  services.openssh = {
	enable = true;
	ports = [ 2973 ];
	settings.PasswordAuthentication = false;
	settings.KbdInteractiveAuthentication = false;
  };
}

