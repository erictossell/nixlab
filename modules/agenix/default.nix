{ agenix, ... }:
{
  imports = [
    agenix.nixosModules.default
  ];
  environment.systemPackages = [ agenix.packages."aarch64-linux".default  ];
}
