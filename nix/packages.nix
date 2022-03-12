{ nixpkgs ? import <nixpkgs> { } }:
let pkgs = {
  atomi = (
    with import (fetchTarball "https://github.com/kirinnee/test-nix-repo/archive/refs/tags/v8.2.1.tar.gz");
    {
      inherit pls;
    }
  );
  "Unstable 26th Feb 2022" = (
    with import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7f9b6e2babf232412682c09e57ed666d8f84ac2d.tar.gz") { };
    {
      inherit
      unzip
        android-tools
        flutter
        dart
        git
        pre-commit
        shfmt
        shellcheck
        nixpkgs-fmt
        bash
        coreutils
        jq
        gnugrep;
      prettier = nodePackages.prettier;
    }
  );
}; in
with pkgs;
pkgs.atomi // pkgs."Unstable 26th Feb 2022"
