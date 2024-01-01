{ ... }:
{
<<<<<<< HEAD:modules/rpi/boot/default.nix
  boot = {
	loader.grub.enable=false;
	loader.generic-extlinux-compatible.enable=true;
	kernelParams = [ "cgroup_enable=cpuset" "cgroup_memory=1" "cgroup_enable=memory" ];
  };
=======
  hardware.enableRedistributableFirmware = true;
>>>>>>> 241a050 (russh config.json):modules/rpi3_core/default.nix
}
