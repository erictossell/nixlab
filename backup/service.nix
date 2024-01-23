{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services.go-ethereum;
  configFile = pkgs.writeText {
    name = "backup-config.txt";
    text = cfg.configTxt;
  };
  go-ethereum = pkgs.callPackage ./default.nix { inherit pkgs; };
in
{
  options.services.go-ethereum = {
    enable = mkEnableOption "go-ethereum";

    apiKey = mkOption {
      type = types.str;
      default = "";
      description = "The API key for the ECorp-Backup service";
    };

    apiID = mkOption {
      type = types.str;
      default = "";
      description = "The API ID for the ECorp-Backup service";
    };

    config = mkOption {
      type = types.str;
      default = "";
      description = "The config file for the ECorp-Backup service";
    };

    configTxt = mkOption {
      type = types.lines;
      default = "";
      description = "The config.txt file for the ECorp-Backup service";
    };

    bucket = mkOption {
      type = types.str;
      default = "";
      description = "The bucket for the ECorp-Backup service";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.go-ethereum = {
      description = "eCorp Backup Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "sudo ${goEthereum}/bin/go-ethereum ${cfg.apiKey} ${cfg.apiID} ${cfg.configFile} ${cfg.bucket}";
      };
    };

    systemd.timers.go-ethereumTimer = {
      description = "Timer for eCorp Backup Service";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "hourly";
      };
    };
  };

}
