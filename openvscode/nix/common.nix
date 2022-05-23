{ project ? import ./. {}
}:

with project.pkgs; [
      curl
      git
      kubectl
      pwgen
      kubectx
      jq
      ripgrep
      argocd
      skopeo
  ]
