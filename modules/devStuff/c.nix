{
  lib,
  pkgs,
  enableCTooling,
  ...
}:
{
  home.packages = (
    lib.optionals enableCTooling [
      pkgs.clang
      pkgs.cmake
      pkgs.gnumake
      pkgs.ninja
    ]

  );
}
