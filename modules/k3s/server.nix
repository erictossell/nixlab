{ 
  #age.secrets."k3s_key" = {
#	file = ../../secrets/k3s.age;
#	path = "/run/secrets/k3s_key";
#  };
  services.k3s = {
    enable = true;
    role = "server";
    token = "secret";
    clusterInit = true;
  };
}
