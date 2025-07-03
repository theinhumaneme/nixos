{
  pkgs,
  userName,
  pkgsUnstable,
  ...
}:
{
  services = {
    displayManager.gdm.enable = true; # enable gdm to use wayland
    displayManager.gdm.wayland = true; # configure gdm to use wayland
    desktopManager.gnome.enable = true; # enable gnome
    gnome.gnome-remote-desktop.enable = false; # disable gnome-remote-desktop service
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany # web browser
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    geary # email client
    gnome-characters
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-connections
    gnome-tour
    decibels
    gnome-system-monitor
    seahorse
    gnome-font-viewer
    gnome-console
  ];

  fonts.packages = with pkgsUnstable; [
    nerd-fonts.fira-code
  ];
  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
      gnome-firmware
      foliate
      collision
      curtail
      resources
      ptyxis
      papers
    ]
    # Customization and Tweaks
    ++ (with pkgs; [
      # gnome-gnome-tweaks
      # gnomeExtensions.dash2dock-lite
      # gnomeExtensions.blur-my-shell
      # gnomeExtensions.vitals
      # gnomeExtensions.clipboard-history
      # bibata-cursors
      # papirus-icon-theme
    ]);
}
