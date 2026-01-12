{
  pkgsUnstable,
  pkgsStable,
  ...
}:
{
  home.packages = (
    (with pkgsStable; [ ])
    ++ (with pkgsUnstable; [
      telegram-desktop
    ])
  );
}