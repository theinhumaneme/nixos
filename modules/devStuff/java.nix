{
  lib,
  pkgs,
  enableJavaTooling,
  ...
}:
{
  home.packages = (
    lib.optionals enableJavaTooling [
      pkgs.jdk21_headless
      pkgs.maven
    ]
  );
}
