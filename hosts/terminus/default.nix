{ system, nixpkgs, ... }:
{
  nixpkgs.hostPlatform = {
    system = "${system}";
  };

}
