{ pkgs, hostName, ... }:
{
  services.openldap = {
    enable = true;

    urlList = [ "ldap:///" ];

    settings = {
      attrs = {
        olcLogLevel = "conns config";

        /* settings for acme ssl */
        #olcTLSCACertificateFile = "/var/lib/acme/${hostName}/full.pem";
        #olcTLSCertificateFile = "/var/lib/acme/${hostName}/cert.pem";
        #olcTLSCertificateKeyFile = "/var/lib/acme/${hostName}/key.pem";
        #olcTLSCipherSuite = "HIGH:MEDIUM:+3DES:+RC4:+aNULL";
        #olcTLSCRLCheck = "none";
        #olcTLSVerifyClient = "never";
        #olcTLSProtocolMin = "3.1";
      };

      children = {
        "cn=schema".includes = [
          "${pkgs.openldap}/etc/schema/core.ldif"
          "${pkgs.openldap}/etc/schema/cosine.ldif"
          "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
        ];

        "olcDatabase={1}mdb".attrs = {
          objectClass = [ "olcDatabaseConfig" "olcMdbConfig" ];

          oldDatabase = "{1}mdb";
          olcDbDirectory = "/var/lib/openldap/data";

          olcSuffix = "dc=tossell,dc=ca";

          olcRootDN = "cn=admin,dc=tossell,dc=ca";
          olcRootPW.path = pkgs.writeText "olcRootPW" "pass";

          olcAccess = [
            /* custom access rules for userPassword attributes */
            ''{0}to attrs=userPassword
                by self write
                by anonymous auth
                by * none''

            /* allow read on anything else */
            ''{1}to *
                by * read''
          ];#olcAccess
        };#attrs
      };#children
    };#settings
  };#openldap

  /* ensure openldap is launched after certificates are created */
  #systemd.services.openldap = {
  #  wants = [ "acme-${hostName}.service" ];
  #  after = [ "acme-${hostName}.service" ];
  #};

  #security.acme.acceptTerms = true;
  #security.acme.defaults.email = "eric@tossell.ca";

  #/* make acme certificates accessible by openldap */
  #security.acme.defaults.group = "certs";
  #users.groups.certs.members = [ "openldap" ];

  #/* trigger the actual certificate generation for your hostname */
  #security.acme.certs."${hostName}" = {
  #  extraDomainNames = [];
  #};

  #/* example using hetzner dns to run letsencrypt verification */
  #security.acme.defaults.dnsProvider = "hetzner";
  #security.acme.defaults.credentialsFile = pkgs.writeText "credentialsFile" ''
  #  HETZNER_API_KEY=<your-hetzner-dns-api-key>
  #'';

}
