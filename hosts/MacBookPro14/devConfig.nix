{
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:
let
  enableCTooling = true;
  enableDevTools = true;
  enableDocker = false;
  enableJavaTooling = true;
  enableNodeJsTooling = false;
  enableRustTooling = true;
in
{
  _module.args = {
    inherit
      enableCTooling
      enableDevTools
      enableDocker
      enableJavaTooling
      enableNodeJsTooling
      enableRustTooling
      ;
  };

  imports =
    [ ]
    ++ lib.optionals enableCTooling [ ../../modules/devStuff/c.nix ]
    ++ lib.optionals enableDevTools [ ../../modules/devStuff/common.nix ]
    ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ]
    ++ lib.optionals enableJavaTooling [ ../../modules/devStuff/java.nix ]
    ++ lib.optionals enableNodeJsTooling [ ../../modules/devStuff/nodejs.nix ]
    ++ lib.optionals enableRustTooling [ ../../modules/devStuff/rust.nix ];
}
