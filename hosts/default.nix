{ hostName, user, ... }:
{
  imports = [
    ./${hostName}/hardware-configuration.nix
  ];
}
