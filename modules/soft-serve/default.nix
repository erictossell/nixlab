{
  services.soft-serve = {
    enable = true;
    settings = {
      name = "E-Corp Git";
      log_format = "text";
      ssh = {
        listen_addr = ":2222";
	public_url = "ssh://eriim.dev:2222";
	max_timeout = 30;
	idle_timeout = 120;
      };
      stats.listen_addr = ":23233";
      initial_admin_keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAETSTzRnvYIQsOwhdwcbVRyZVnP6/F3b+inurb9+RMu" ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 2222 23232 23233 ]; 
}
