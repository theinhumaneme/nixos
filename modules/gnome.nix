{
  pkgs,
  userName,
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
  ];

  users.users."${userName}".packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-history
    banana-cursor
    gnome-firmware
    papers
    bibata-cursors
    tela-icon-theme
    foliate
  ];
}
