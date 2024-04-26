{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
  };
}
