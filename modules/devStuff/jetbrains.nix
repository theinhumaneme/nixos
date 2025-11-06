{
  lib,
  pkgs,
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
      pkgs.jetbrains.idea-ultimate
    ]
    ++ lib.optionals enablePyCharmProfessional [
      pkgs.jetbrains.pycharm-professional
    ]
    ++ lib.optionals enableRustRover [
      pkgs.jetbrains.rust-rover
    ]
    ++ lib.optionals enableWebStorm [
      pkgs.jetbrains.webstorm
    ]
    ++ lib.optionals enableDataGrip [
      pkgs.jetbrains.datagrip
    ]
  );
}
