{
  lib,
  pkgsUnstable,
  userName,
  enableDevTools,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableDevTools [
      pkgsUnstable.zed-editor-fhs
      pkgsUnstable.lazygit
      # pkgsUnstable.dbeaver-bin
      # pkgsUnstable.postman
      # pkgsUnstable.github-desktop
      # pkgsUnstable.vscode-fhs
    ]
  );
}
