{
  lib,
  ...
}:
let
  enableAutoCpuFreq = false;
  enableDocker = true;
  enableTLP = false;
in
{
  _module.args = {
    inherit
      enableDocker
      ;
  };

  imports =
    [ ]
    ++ lib.optionals enableAutoCpuFreq [ ../../modules/auto-cpufreq.nix ]
    ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ]
    ++ lib.optionals enableTLP [ ../../modules/tlp.nix ];
}
