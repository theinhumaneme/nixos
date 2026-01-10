{
  pkgsUnstable,
  pkgsStable,
  ...
}:
{
  home.packages = (
      (with pkgsStable; []) ++ (with pkgsUnstable; [
        vscode
        obsidian
        telegram-desktop
        nixfmt-rfc-style
        prettier
        kdlfmt
      ])
    );
}
