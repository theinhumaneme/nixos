{
  lib,
  pkgsUnstable,
  ...
}:
let
  enableIntelijIdeaUltimate = true;
  enablePyCharmProfessional = false;
  enableRustRover = false;
  enableWebStorm = false;
  enableDataGrip = false;
in
{
  home.packages = (
    lib.optionals enableIntelijIdeaUltimate [
      pkgsUnstable.jetbrains.idea
    ]
    ++ lib.optionals enablePyCharmProfessional [
      pkgsUnstable.jetbrains.pycharm
    ]
    ++ lib.optionals enableRustRover [
      pkgsUnstable.jetbrains.rust-rover
    ]
    ++ lib.optionals enableWebStorm [
      pkgsUnstable.jetbrains.webstorm
    ]
    ++ lib.optionals enableDataGrip [
      pkgsUnstable.jetbrains.datagrip
    ]
  );
}
