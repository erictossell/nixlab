{ interface, ...}:
{
  networking.wireless = {
    enable = true;
    interface = [ "${interface}" ];
    userControlled.enable = true;
  };
}
