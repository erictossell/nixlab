{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [ go gopls gotools golangci-lint backblaze-b2 ];
}
