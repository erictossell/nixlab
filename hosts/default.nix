{ hostName, ... }:
{
  imports = [
    ./${hostName}/hardware-configuration.nix
  ];
}
