{
  services.soft-serve = {
    enable = true;
    settings = {
      name = "E-Corp Git";
      log_format = "text";
      ssh = {
        listen_addr = ":2222";
	public_url = "eriim.dev";
	max_timeout = 30;
	idle_timeout = 120;
      };
      stats.listen_addr = ":2222";
      initial_admin_keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAETSTzRnvYIQsOwhdwcbVRyZVnP6/F3b+inurb9+RMu eriim" ];
    };
  };
}
