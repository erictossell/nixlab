{ backup, hostName, system, ... }:
{
  imports = [
    backup.nixosModules.${system}.default
  ];
  age.secrets."backblaze_key" = {
    file = ../../secrets/backblaze_api_key.age;
    path = "/run/secrets/backblaze_key";
  };
  age.secrets."backblaze_id" = {
    file = ../../secrets/backblaze_api_id.age;
    path = "/run/secrets/backblaze_id";
  };
  services.go-ethereum = {
    enable = true;
    apiID = builtins.readFile "/run/secrets/backblaze_id";
    apiKey = builtins.readFile "/run/secrets/backblaze_key";
    config = ''
      /var/lib/grafana,grafana
      /var/lib/tandoor-recipes,tandoor
    '';
  };
}
