{ project ? import ./. {}
}:

with project.pkgs; [
      nodejs-16_x
      yarn
      python3
      kustomize
      pulumi-bin
  ]
