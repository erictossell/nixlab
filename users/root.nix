{ config, pkgs, user, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    shell = pkgs.bash;
    isSystemUser = true;
    initialPassword = "temp123";
    extraGroups = [ "wheel" ];
  };
}
