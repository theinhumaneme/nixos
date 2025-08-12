{
  userName,
  pkgsUnstable,
  ...
}:
{
  users.users."${userName}".packages =
    # Apps
    with pkgsUnstable; [
      baobab # Disk Usage Analyzer
      collision # Gnome Circle Checksum App
      curtail # image compression tool
      foliate # e-pub reader
      gnome-obfuscate # Censor Private Information
      gnome-text-editor # Gnome Text Editor App
      loupe # Gnome Image Viewer
      papers # PDF Viewer
      papers # latest document-viewer
      resources # Gnome Resources
      varia # Download Manager Based on aria2c and yt-dlp
      cosmic-files # cosmic file manager
      gnome-calculator # Gnome Calculator
      gnome-power-manager # Gnome Power Manager
    ];

}
