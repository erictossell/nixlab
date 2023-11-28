{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [ docker-compose ];

  # Docker can also be run rootless
  virtualisation.docker = {
    enable = true;
  };
  # User permissions 
  users.users.${user}.extraGroups = [ "docker" ];

  systemd.services.firefly = {
    wantedBy = [ "mult-user.target" ];
    after = [ "network.target" "docker.service" ];
    requires = [ "docker.service" ];
    script = ''
      ${pkgs.docker-compose}/bin/docker-compose -f ./firefly/docker-compose.yml up
      '';
    preStop = ''
      ${pkgs.docker-compose}/bin/docker-compose -f ./firefly/docker-compose.yml down
    '';

  };
}
