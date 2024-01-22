{ ... }:
{
  services.nginx = {
    enable = true;
     # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "eric@tossell.ca";
  };

}
