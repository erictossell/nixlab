{ nixpkgs, ... }: {
  imports = [ (nixpkgs + "/nixos/modules/virtualisation/amazon-image.nix") ];
}
