{
  lib,
  pkgsUnstable,
  userName,
  enableVSCode,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableVSCode(
      with pkgsUnstable;
      [
         vscode-fhs
      ]
      ++ (with pkgsUnstable; [
        nixfmt-rfc-style
        prettier
        kdlfmt
      ])
    )
  );
}
