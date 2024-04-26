{ config, pkgs, ... }:
{
  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
  };
}
