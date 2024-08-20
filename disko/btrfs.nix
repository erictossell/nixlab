{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/sda"; 
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "550M"; # ESP partition size to 550M as per your script
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%"; # Allocating the rest of the disk to the root partition, excluding ESP
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  # Swap subvolume setup
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "2G";
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
