{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/sda"; # Adjusted to /dev/sda for VM scenario
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M"; # Adjusted for a more standard ESP size
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "rest"; # Adjust size according to your disk layout and needs
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Force, ensuring it's okay to overwrite
                subvolumes = {
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol"; # Dedicated swap subvolume
                  };
                };

                mountpoint = "/partition-root"; # Not typically needed as subvolumes are used
                swap = {
                  swapfile = {
                    size = "2G"; # Adjusted to a more practical size
                    path = "/.swapvol/swapfile"; # Explicitly define path within subvolume
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

