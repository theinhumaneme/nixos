{
  userName,
  pkgs,
  ...
}:
{
  # Enable the Gnome Virtual File System
  services.gvfs.enable = true;

  users.users."${userName}".packages =
    # Apps
    with pkgs; [
      baobab # Disk Usage Analyzer
      collision # Gnome Circle Checksum App
      curtail # image compression tool
      foliate # e-pub reader
      gnome-calculator # Gnome Calculator
      gnome-clocks # Clocks App
      gnome-obfuscate # Censor Private Information
      gnome-power-manager # Gnome Power Manager
      gnome-text-editor # Gnome Text Editor App
      keypunch # Typing Practice
      loupe # Gnome Image Viewer
      newsflash # RSS Reader
      papers # PDF Viewer
      papers # latest document-viewer
      resources # Gnome Resources
      varia # Download Manager Based on aria2c and yt-dlp
      eyedropper # gnome-color-picker
      gnome-calendar # gnome-calendar
      pomodoro-gtk # pomodoro app
      cloudflared
    ];

  # ============================ #
  # Program Configurations
  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "dcd6dbde-e116-4755-a48a-dc88a8cd8227" = {
        credentialsFile = "/home/kalyanm/.cloudflared/dcd6dbde-e116-4755-a48a-dc88a8cd8227.json";
        default = "http_status:404";
        ingress = {
          "couch-db.kalyanmudumby.com" = "http://localhost:5984";
        };
      };

    };
  };
  # ============================ #
}
