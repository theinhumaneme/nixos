{
  lib,
  ...
}:
let
  enableCTooling = true;
  enableDevTools = true;
  enableJavaTooling = true;
  enableNeoVim = false;
  enableNodeJsTooling = false;
  enableRustTooling = true;
  enableJetbrains = true;
  enableRTooling = true;
  enableVSCode = true;
  enableZedEditor = false;
in
{
  _module.args = {
    inherit
      enableCTooling
      enableDevTools
      enableJavaTooling
      enableNodeJsTooling
      enableRustTooling
      enableJetbrains
      enableRTooling
      enableVSCode
      enableZedEditor
      ;
  };

  imports =
    [ ]
    ++ lib.optionals enableCTooling [ ../../modules/devStuff/c.nix ]
    ++ lib.optionals enableDevTools [ ../../modules/devStuff/common.nix ]
    ++ lib.optionals enableJavaTooling [ ../../modules/devStuff/java.nix ]
    ++ lib.optionals enableNeoVim [ ../../modules/devStuff/neovim/neovim.nix ]
    ++ lib.optionals enableNodeJsTooling [ ../../modules/devStuff/nodejs.nix ]
    ++ lib.optionals enableRustTooling [ ../../modules/devStuff/rust.nix ]
    ++ lib.optionals enableJetbrains [ ../../modules/devStuff/jetbrains.nix ]
    ++ lib.optionals enableRTooling [ ../../modules/devStuff/r.nix ]
    ++ lib.optionals enableVSCode [ ../../modules/devStuff/vscode.nix ];
}
