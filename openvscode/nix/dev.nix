{ project ? import ./. {}
}:
let
  common = import ./common.nix {};
  node = import ./node.nix {};
  scala = import ./scala.nix {};
in with project.pkgs; [ nix kubectl kubectx ] ++ common ++ node ++ scala
