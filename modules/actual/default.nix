{ config, pkgs, ... }:
 {
   config.virtualisation.oci-containers.containers = {
     actual = {
       image = "actualbudget/actual-server:latest";
       ports = ["127.0.0.1:8443:5006"];
       volumes = [
         "/srv/actual-data:/data"
	 "/srv/actual-data/cert.crt:/data/cert.crt"
	 "/srv/actual-data/key.key:/data/key.key"
       ];
       environment = {
         ACTUAL_HTTPS_KEY="/data/key.key";
	 ACTUAL_HTTPS_CERT="/data/cert.crt";
       };
       cmd = [
         "--pull=always"
         "--restart=unless-stopped"
	 "-d"
       ];
     };
   };
}
