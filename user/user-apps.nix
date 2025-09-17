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
