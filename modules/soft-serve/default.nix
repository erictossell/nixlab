{

  age.secrets."host_key" = {
    file = ../../secrets/soft_serve_host.age;
    path = "/run/secrets/soft_serve_host";
  };
  age.secrets."client_key" = {
    file = ../../secrets/soft_serve_client.age;
    path = "/run/secrets/soft_serve_client";
  };
  services.soft-serve = {
    enable = true;
    settings = {
      name = "EriimHub";
      log_format = "text";
      ssh = {
        listen_addr = ":2973";
        public_url = "ssh://git.eriimhub";
        key_path = "/run/secrets/soft_serve_host";
        client_key_path = "/run/secrets/soft_serve_client";
        max_timeout = 10;
        idle_timeout = 180;
      };
      git = {
        listen_addr = ":9418";
        max_timeout = 5;
        idle_timeout = 3;
        max_connections = 10;
      };
      http = {
        listen_addr = ":443";
        public_url = "http://git.eriimhub";
      };
      stats = {
        listen_addr = "localhost:23233";
      };
      initial_admin_keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGpjd0YtPFSDTNkA4UcYjfMlAEr3s3mEpiKxU7jabJSG";
    };
  };
}
