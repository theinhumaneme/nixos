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
        aria
        android-tools
        btop-rocm
      ]
      ++ (with pkgsUnstable; [
        mpv
        obsidian
        spotify
        mpv
        fastfetch
        transmission_4-gtk
        telegram-desktop
        stremio
        jellyfin-media-player
        discord
        zoom-us
        gimp
        libreoffice-qt6-fresh
      ]);
  };

}
