{ interface, ... }:
{
  networking.wireless = {
    enable = true;
    interfaces = [ "${interface}" ];
    userControlled.enable = true;
  };
}
