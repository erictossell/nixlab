{
  age.secrets."tailscale_key" = {
    file = ../../secrets/tailscale.age;
    path = "/run/secrets/tailscale_key";
  };
  services.tailscale = {
    enable = true;
    authKeyFile = "/run/secrets/tailscale_key";
  };
  services.openssh = {
    enable = true;
  };
}
