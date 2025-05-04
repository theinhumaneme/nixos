{
  config,
  lib,
  pkgs,
  userName,
  enableJavaTooling,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableJavaTooling [
      pkgs.jdk
      pkgs.maven
    ]
  );
}
