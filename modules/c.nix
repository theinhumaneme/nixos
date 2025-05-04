{
  config,
  lib,
  pkgs,
  userName,
  enableCTooling,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableCTooling [
      pkgs.gcc
      pkgs.clang
      pkgs.cmake
      pkgs.gnumake
      pkgs.ninja
    ]

  );
}
