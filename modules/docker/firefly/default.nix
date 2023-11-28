{ pkgs, ... }:
{
  age.secrets."firefly_env" = {
	file = ../../../secrets/firefly_env.age;
	path = "/run/secrets/firefly.env";
  };
  age.secrets."firefly_db" = {
	file = ../../../secrets/firefly_db.age;
	path = "/run/secrets/firefly.db.env";
  };


  systemd.services.firefly = {
    wantedBy = [ "mult-user.target" ];
    after = [ "network.target" "docker.service" ];
    requires = [ "docker.service" ];
    script = ''
      ${pkgs.docker-compose}/bin/docker-compose -f ./docker-compose.yml up
      '';
    preStop = ''
      ${pkgs.docker-compose}/bin/docker-compose -f ./docker-compose.yml down
    '';

  };
}
