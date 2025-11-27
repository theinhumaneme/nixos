{
  lib,
  pkgsUnstable,
  userName,
  enableDevTools,
  ...
}:
{
  imports = [ ./jetbrains.nix ];
  users.users."${userName}".packages = (
    lib.optionals enableDevTools (
      with pkgsUnstable;
      [
        # dbeaver-bin
        # github-desktop
        gemini-cli
        git
        lazygit
        ripgrep
        tmux
        hugo
        postman
      ]
    )
  );
}
