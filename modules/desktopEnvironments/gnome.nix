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

  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
      gnome-firmware
      foliate # e-pub reader
      collision # checksum application
      curtail # image compression tool
      resources # better system-monitor
      ghostty
      papers # latest document-viewer
      gradia # screenshot application
    ]
    # Customization and Tweaks
    ++ (with pkgs; [
      #      gnome-tweaks
      #      gnomeExtensions.dash2dock-lite
      gnomeExtensions.blur-my-shell
      #      gnomeExtensions.vitals
      gnomeExtensions.clipboard-history
    ]);

  home-manager.users."${userName}" = import ./home-gnome.nix { inherit pkgs pkgsUnstable; };
}
