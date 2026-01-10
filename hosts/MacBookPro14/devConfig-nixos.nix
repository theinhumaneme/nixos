{
  lib,
  ...
}:
let
  enableDocker = false;
in
{
  _module.args = {
    inherit
      enableDocker
      ;
  };

  imports = [ ] ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ];
}
