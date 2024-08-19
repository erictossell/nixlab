{
  services.nginx = {
    enable = true;
    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  security.acme = {
    acceptTerms = true;
    defaults.email = "eric@tossell.ca";
  };

}
