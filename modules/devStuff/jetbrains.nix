{
  lib,
  pkgsUnstable,
  userName,
  ...
}:
let
  enableIntelijIdeaUltimate = false;
  enablePyCharmProfessional = false;
  enableRustRover = false;
  enableWebStorm = false;
  enableDataGrip = false;
in
{
  users.users."${userName}".packages = (
    lib.optionals enableIntelijIdeaUltimate [
      pkgsUnstable.jetbrains.idea-ultimate
    ]
    ++ lib.optionals enablePyCharmProfessional [
      pkgsUnstable.jetbrains.pycharm-professional
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
