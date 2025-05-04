{
  config,
  lib,
  pkgsUnstable,
  userName,
  enableDevTools,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableDevTools [
      pkgsUnstable.zed-editor
      pkgsUnstable.vscode-fhs
      pkgsUnstable.github-desktop
      pkgsUnstable.lazygit
    ]
  );
}
