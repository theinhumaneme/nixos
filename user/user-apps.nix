{
  pkgs,
  pkgsUnstable,
  userName,
  ...
}:
{
  users.users = {
    "${userName}".packages =
      with pkgs;
      [
        android-tools # fastboot + adb
        aria # CLI based download manager
        btop-rocm # Terminal Resource Monitor
      ]
      ++ (with pkgsUnstable; [
        bitwarden-desktop # Passoword Manager
        discord
        element-desktop # Matrix Client
        fastfetch # terminal sysinfo
        gimp
        libreoffice-qt6-fresh
        mpv
        obsidian
        spotify
        telegram-desktop
        zoom-us
      ]);
  };

}
