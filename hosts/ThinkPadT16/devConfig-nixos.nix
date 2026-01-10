{
  lib,
  ...
}:
let
  enableAutoCpuFreq = false;
  enableDocker = true;
  enableTLP = false;
  enableZedEditor = false;
  enableVSCode = true;
in
{
  _module.args = {
    inherit
      enableDocker
      enableZedEditor
      enableVSCode
      ;
  };

  imports =
    [ ]
    ++ lib.optionals enableAutoCpuFreq [ ../../modules/auto-cpufreq.nix ]
    ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ]
    ++ lib.optionals enableTLP [ ../../modules/tlp.nix ]
    ++ lib.optionals enableZedEditor [ ../../modules/devStuff/zed.nix ]
    ++ lib.optionals enableVSCode [ ../../modules/devStuff/vscode.nix ];
}
