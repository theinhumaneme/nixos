{
  lib,
  pkgsUnstable,
  enableDevTools,
  ...
}:
{
  imports = [ ./jetbrains.nix ];
  home.packages = (
    lib.optionals enableDevTools (
      with pkgsUnstable;
      [
        gemini-cli
        git
        lazygit
        ripgrep
        tmux
        hugo
      ]
    )
  );
}
