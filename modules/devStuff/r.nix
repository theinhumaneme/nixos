{
  lib,
  pkgs,
  pkgsUnstable,
  enableRTooling,
  ...
}:
{
  home.packages = (
    lib.optionals enableRTooling (
      with pkgs;
      [
        R
      ]
      ++ (with pkgsUnstable; [
        rstudio
      ])
    )
  );
}
