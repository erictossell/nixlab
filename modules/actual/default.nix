{ config, pkgs, user, ... }:
let
  data_path = "/srv/actual-data/";
  compose_path = "/home/${user}/actual";
in
{
  environment.etc."${compose_path}/compose.yaml".source = ./compose.yaml;

  systemd.services.actualServer = {
    serviceConfig = {
      Environment = "PATH=/run/current-system/sw/bin";
      Type = "simple";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "docker.service" ];
    script = ''
      cd ${compose_path}
      ${pkgs.docker-compose}/bin/docker-compose up --detach
    '';
    preStop = ''
      cd ${compose_path}
      ${pkgs.docker-compose}/bin/docker-compose down
    '';
  };

}
