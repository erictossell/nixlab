{ pkgs ? import <nixpkgs> { } }:

pkgs.buildGoModule {
  pname = "go-ethereum";
  version = "0.1.0";
  src = ./.;
  vendorHash = null;
}

