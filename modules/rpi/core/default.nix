{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [ libraspberrypi ];
}
