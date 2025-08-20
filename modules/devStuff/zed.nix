{
  lib,
  pkgsUnstable,
  userName,
  enableZedEditor,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableZedEditor (
      with pkgsUnstable;
      [
        zed-editor-fhs
      ]
      ++ (with pkgsUnstable; [
        nixfmt-rfc-style
        prettier
        kdlfmt
      ])
    )
  );
}
