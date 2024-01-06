{ pkgs, ...}:
{ 
  # https://github.com/lovesegfault/nix-config/blob/e412cd01cda084c7e3f5c1fbcf7d99665999949e/core/nixos.nix#L39
  system = {
    extraSystemBuilderCmds= ''
      ln -sv ${pkgs.path} $out/nixpkgs
    '';
  };

  # Enable Flakes and nix-commands, enable removing channels
  nix = {
    nixPath = [ "nixpkgs=/run/current-system/nixpkgs" ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

}
