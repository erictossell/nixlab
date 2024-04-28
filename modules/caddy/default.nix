{ ... }:
{
  imports = [ ./git.nix ];
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.caddy = {
    enable = true;
    virtualHosts = {
      "eriim.dev" = {
        serverAliases = [ "www.eriim.dev" ];
        extraConfig = ''
                    root * /var/www/eriim.dev/html
          	  file_server
          	'';
      };

      "homepage.eriim.dev" = {
        serverAliases = [ "www.homepage.eriim.dev" ];
        extraConfig = ''
                    root * /var/www/homepage.eriim.dev/homepage
          	  file_server
          	'';
      };
    };
  };
}
