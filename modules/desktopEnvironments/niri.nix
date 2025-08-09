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
      gnome-keyring # for secret management
      xdg-desktop-portal-gnome # required for screen-casting
      xdg-desktop-portal-gtk
    ]
    ++ (with pkgsUnstable; [
      kitty # terminal
      brightnessctl # Manage Display Backlight
      hypridle # Hypr Ecosystem Idle Daemon
      hyprlock # Hypr Ecosystem LockScreen
      mako # notification daemon
      networkmanagerapplet # Network Manager GUI
      pavucontrol # Audio Control GUI
      swww # Wallpaper Daemon
      walker # Application Launcher
      waybar # Status Bar
      xwayland-satellite # XWayland Integration
    ]);

  # All Common Desktop Apps
  imports = [ ./desktop-apps.nix ];
  #  home-manager.users."${userName}" = import ./home-gnome.nix { inherit pkgs pkgsUnstable; };

}
