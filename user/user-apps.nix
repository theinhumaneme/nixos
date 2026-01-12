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
      ]
      ++ (with pkgsUnstable; [
        bitwarden-desktop
        # element-desktop # Matrix Client
        gimp
        libreoffice-qt6-fresh
        mpv
        spotify
        telegram-desktop
        zoom-us
        slack
      ]);
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

}
