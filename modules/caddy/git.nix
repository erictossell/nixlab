{ pkgs, ... }:
{
  # Ensure git is available
  environment.systemPackages = with pkgs; [ git coreutils ];

  systemd.services.clone-homepage = {
    description = "Clone GitHub repository to web directory";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.git}/bin/git clone --depth 1 https://github.com/erictossell/homepage.git /var/www/homepage.eriim.dev/homepage";
      ExecStartPre = "${pkgs.coreutils}/bin/rm -rf /var/www/homepage.eriim.dev/homepage";
    };
  };

  # Ensure the directory ownership and permissions, if needed
  systemd.tmpfiles.rules = [
    "d /var/www/homepage.eriim.dev/homepage 0755 root root - -"
  ];
}

