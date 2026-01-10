{
  lib,
  ...
}:
let
  enableCTooling = true;
  enableDevTools = true;
  enableJavaTooling = true;
  enableNodeJsTooling = false;
  enableRustTooling = true;
  enablePodman = false;
  enableJetbrains = true;
  enableRTooling = true;
in
{
  _module.args = {
    inherit
      enableCTooling
      enableDevTools
      enableJavaTooling
      enableNodeJsTooling
      enableRustTooling
      enablePodman
      enableJetbrains
      enableRTooling
      ;
  };

  imports =
    [./home.nix ]
    ++ lib.optionals enableCTooling [ ../../modules/devStuff/c.nix ]
    ++ lib.optionals enableDevTools [ ../../modules/devStuff/common.nix ]
    ++ lib.optionals enableJavaTooling [ ../../modules/devStuff/java.nix ]
    ++ lib.optionals enableNodeJsTooling [ ../../modules/devStuff/nodejs.nix ]
    ++ lib.optionals enableRustTooling [ ../../modules/devStuff/rust.nix ]
    ++ lib.optionals enablePodman [ ../../modules/devStuff/podman.nix ]
    ++ lib.optionals enableJetbrains [ ../../modules/devStuff/jetbrains.nix ]
    ++ lib.optionals enableRTooling [ ../../modules/devStuff/r.nix ];
}
