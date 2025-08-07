{
  pkgs,
  pkgsUnstable,
  userName,
  ...
}:
{
  services = {
    displayManager = {
      sddm.wayland.enable = true;
      sddm.enable = true;
    };
  };
  programs = {
    niri = {
      package = pkgs.niri_git;
      enable = true;
    };
  };
  # Enable Polkit Service
  security.polkit.enable = true;
  # Enable Gnome Keyring for Niri
  security.pam.services.niri.enableGnomeKeyring = true;
  # Add a service to start the gnome-polkit agent on startup
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome # required for screen-casting
      gnome-keyring # for secret management
    ]
    ++ (with pkgsUnstable; [
      xwayland-satellite # XWayland Integration
      mako # notification daemon
      alacritty # terminal
      walker # Application Launcher
      waybar # Status Bar
      hyprlock # Hypr Ecosystem LockScreen
      hypridle # Hypr Ecosystem Idle Daemon
      nautilus # Gnome FileManager
      resources # Gnome Resources
      pavucontrol # Audio Control GUI
      networkmanagerapplet # Network Manager GUI
      swww # Wallpaper Daemon
      brightnessctl # Manage Display Backlight
      papers # PDF Viewer
      loupe # Gnome Image Viewer
      collision # Gnome Circle Checksum App
      gnome-text-editor
    ]);
  #  home-manager.users."${userName}" = import ./home-gnome.nix { inherit pkgs pkgsUnstable; };

}
