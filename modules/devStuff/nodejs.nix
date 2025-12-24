{
  lib,
  pkgs,
  enableNodeJsTooling,
  ...
}:
{
  home.packages = (lib.optionals enableNodeJsTooling [ pkgs.nodejs_22 ]);
}
