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
        # zed-editor-fhs
        lazygit
        vscode-fhs
        # dbeaver-bin
        # postman
        # github-desktop

      ]
    )
  );
}
