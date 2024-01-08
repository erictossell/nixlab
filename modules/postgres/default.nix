{ lib, pkgs, user, ... }:
{
  networking.firewall.allowedTCPPorts = [ 9731 ];
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    port = 9731;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "exstructa" "${user}" ];
    identMap = ''
      # AribtraryMapName systemUser DBUser
      superuser_map    root       postgres
      superuser_map    postgres   postgres
      superuser_map    /^(.*)$    \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method optional_ident_map
      local sameuser all    peer        map=superuser_map

      host all all 10.0.0.143/32 md5
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE ${user} WITH LOGIN PASSWORD 'temp123' CREATEDB;
      GRANT ALL PRIVILEGES ON DATABASE exstructa TO ${user};
    '';
    settings = {
      log_connections = true;
      log_statement = "all";
      logging_collector = true;
      log_disconnections = true;
      log_destination = lib.mkForce "syslog";
    };
  };

  services.postgresqlBackup = {
    enable = true;
  };

}
