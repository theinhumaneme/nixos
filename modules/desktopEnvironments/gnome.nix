{
  pkgs,
  userName,
  lib,
  config,
  ...
}:
{
  options.desktop.gnome.enable = lib.mkEnableOption "Gnome Desktop";

  config = lib.mkIf config.desktop.gnome.enable {
    services = {
      displayManager.gdm.enable = true; # enable gdm to use wayland
      displayManager.gdm.wayland = true; # configure gdm to use wayland
      desktopManager.gnome.enable = true; # enable gnome
      gnome.gnome-remote-desktop.enable = false; # disable gnome-remote-desktop service
    };

    environment.gnome.excludePackages = with pkgs; [
      decibels
      epiphany # web browser
      evince # document viewer
      geary # email client
      gnome-characters
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-photos
      gnome-system-monitor
      gnome-tour
      seahorse
      simple-scan # document scanner
      totem # video player
      yelp # help viewer
    ];

    users.users."${userName}".packages =
      # Apps
      with pkgs;
      [
        ptyxis # gnome-49 default terminal
        gnome-power-manager # power management tool
        gradia # screenshot application
      ]
      # Customization and Tweaks
      ++ (with pkgs; [
        #      gnome-tweaks
        gnomeExtensions.dash2dock-lite
        gnomeExtensions.vitals
        gnomeExtensions.blur-my-shell
        gnomeExtensions.clipboard-history
      ])
      # Packages required for the Gnome Files and File Roller
      ++ (with pkgs; [
        _7zz
        file-roller # Gnome File Archive Tool
        nautilus # Gnome File Manager
        unrar
        unzip
        zip
      ]);
    # home-manager.users."${userName}" = import ./home-gnome.nix { inherit pkgs pkgsUnstable; };
  };
}
