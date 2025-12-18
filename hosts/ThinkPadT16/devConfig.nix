{
  pkgs,
  lib,
  userName,
  ...
}:
let
  enableAutoCpuFreq = false;
  enableCTooling = true;
  enableDevTools = true;
  enableDocker = false;
  enableJavaTooling = false;
  enableNeoVim = false;
  enableNodeJsTooling = false;
  enableRustTooling = true;
  enableTLP = false;
  enableZedEditor = false;
  enableVSCode = true;
in
{
  _module.args = {
    inherit
      userName
      enableCTooling
      enableDevTools
      enableDocker
      enableJavaTooling
      enableNodeJsTooling
      enableRustTooling
      enableZedEditor
      enableVSCode
      ;
  };

  imports =
    [ ]

    ++ lib.optionals enableAutoCpuFreq [ ../../modules/auto-cpufreq.nix ]
    ++ lib.optionals enableCTooling [ ../../modules/devStuff/c.nix ]
    ++ lib.optionals enableDevTools [ ../../modules/devStuff/common.nix ]
    ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ]
    ++ lib.optionals enableJavaTooling [ ../../modules/devStuff/java.nix ]
    ++ lib.optionals enableNeoVim [ ../../modules/devStuff/neovim/neovim.nix ]
    ++ lib.optionals enableNodeJsTooling [ ../../modules/devStuff/nodejs.nix ]
    ++ lib.optionals enableRustTooling [ ../../modules/devStuff/rust.nix ]
    ++ lib.optionals enableTLP [ ../../modules/tlp.nix ]
    ++ lib.optionals enableZedEditor [ ../../modules/devStuff/zed.nix ]
    ++ lib.optionals enableVSCode [ ../../modules/devStuff/vscode.nix ];
}
