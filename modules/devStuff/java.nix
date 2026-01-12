{
  lib,
  pkgs,
  enableJavaTooling,
  ...
}:
lib.mkIf enableJavaTooling {
  programs = {
    java = {
      enable = true;
      package = pkgs.javaPackages.compiler.openjdk11-bootstrap;
    };
  };
  home.packages = [
    pkgs.maven
  ];
}
