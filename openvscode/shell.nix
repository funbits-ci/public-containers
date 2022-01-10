let

  nixpkgs = builtins.fetchTarball {
    name   = "nixos-unstable-2021-06-12";
    url    = "https://github.com/NixOS/nixpkgs/archive/fce0206462cd8b80eaca59542d0c53713044050f.tar.gz";
    sha256 = "0j0n5mr1jxxk6ib7q8v44cvnpq29bfp5b2mhy5f4sr76swiacnbf";
  };

  pkgs = import nixpkgs {};

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

