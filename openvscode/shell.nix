{ jdk ? "jdk11" }:

let

  nixpkgs = builtins.fetchTarball {
    name   = "nixos-unstable-2021-12-27";
    url    = "https://github.com/NixOS/nixpkgs/archive/be5272250926e352427b3c62c6066a95c6592375.tar.gz";
    sha256 = "0rda00l8rdf0a4pdsflg0h7dx6hd52291ymcqv1wljzs9k5zsy7i";
  };

  config = import ./config.nix { inherit jdk; };
  pkgs      = import nixpkgs { inherit config; };

in

  pkgs.mkShell {
    buildInputs = with pkgs; [
      ammonite_2_13   # v2.4.0
      curl            # v7.76.1
      git             # v2.31.1
      jdk11           # v11.0.10
      kind            # v0.11.1
      kubectl         # v1.21.1
      nodejs-14_x     # v14.17.0
      yarn            # v1.22.10
      pre-commit      # v2.7.1
      sops            # v3.6.1
      python3         # v3.8.5
      docker-compose  # v1.26.2
      k9s             # v0.24.8
      sbt             # v1.5.3
      pwgen           # ?
      istioctl        # 1.7.0
      kubectx         # 0.9.1
      jq              # 1.6
      flyway          # 7.1.1
      argocd
    ];
  }

