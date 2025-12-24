{
  lib,
  pkgsUnstable,
  enableDevTools,
  ...
}:
{
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
