{
  lib,
  pkgs,
  enableJavaTooling,
  ...
}:
{
  home.packages = (
    lib.optionals enableJavaTooling [
      pkgs.jdk
      pkgs.maven
    ]
  );
}
