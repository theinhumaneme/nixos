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
        btop-rocm # Terminal Resource Monitor
      ]
      ++ (with pkgsUnstable; [
        bitwarden-desktop # Passoword Manager
        discord
        # element-desktop # Matrix Client
        fastfetch # terminal sysinfo
        gimp
        libreoffice-qt6-fresh
        mpv
        obsidian
        spotify
        telegram-desktop
        zoom-us
        slack
        aria2 # CLI based download manager

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
