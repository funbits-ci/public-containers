{projectName ? (baseNameOf ./.)}:
let
  pkgs = import ./nix {};
  devPkgs = import nix/dev.nix {};
in
  pkgs.mkShell {
    buildInputs = devPkgs;

    shellHook = ''
        set +ex
        echo "Welcome to ${projectName} nix shell"
        source .env
    '';
  }
