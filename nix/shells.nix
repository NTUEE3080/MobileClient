{ nixpkgs ? import <nixpkgs> { } }:
let env = import ./env.nix { inherit nixpkgs; }; in
{
  dev = nixpkgs.mkShell {
    buildInputs = env.system ++ env.dev ++ env.lint ++ [ ];
    shellHook = ''
        export PATH="$HOME/Android/Sdk/platform-tools/:$PATH"
    '';
  };
}
