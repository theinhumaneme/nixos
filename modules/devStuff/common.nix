{
  lib,
  pkgsUnstable,
  userName,
  enableDevTools,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableDevTools (
      with pkgsUnstable;
      [
        # dbeaver-bin
        # github-desktop
        # postman
        gemini-cli
        git
        lazygit
        ripgrep
        tmux

      ]
    )
  );
}
