{
  config,
  pkgs,
  userName,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    gnome-weather
    gnome-connections
    gnome-tour
    gnome-online-accounts
  ];

  users.users."${userName}".packages = with pkgs; [
    gnome-tweaks
  ];

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    gnome.gnome-remote-desktop.enable = false;
  };
  services.xserver.excludePackages = [ pkgs.xterm ];
}
