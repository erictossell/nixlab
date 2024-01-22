{ ... }:
{
  services.nginx = {
    enable = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "eric@tossell.ca";
  };

}
