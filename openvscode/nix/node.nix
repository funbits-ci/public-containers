{ project ? import ./. {}
}:

with project.pkgs; [
      nodejs-17_x
      yarn
      python3
      kustomize
      pulumi-bin
  ]
