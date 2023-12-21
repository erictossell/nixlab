{ ... }:
{
  boot = {
	loader.grub.enable=false;
	loader.generic-extlinux-compatible.enable=true;
	kernelParams = [ "cgroup_enable=cpuset" "cgroup_memory=1" "cgroup_enable=memory" ];
  };
}
