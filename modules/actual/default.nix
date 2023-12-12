{ config, pkgs, user, ... }:
let
  data_path = "/srv/actual-data/";
  compose_path = "/home/${user}/actual";
in
{
  environment.etc."${compose_path}/compose.yaml".source = ./compose.yaml;

  systemd.services.actualServer = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "podman.service" ];
    script = ''
      cd ${compose_path}
      ${pkgs.podman-compose}/bin/podman-compose up --detach
    '';
    preStop = ''
      ${pkgs.podman-compose}/bin/podman-compose down
    '';
  };

}
