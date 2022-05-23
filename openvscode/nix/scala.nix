{ project ? import ./. {}
}:

with project.pkgs; [
      jdk11
      sbt
      flyway
  ]
