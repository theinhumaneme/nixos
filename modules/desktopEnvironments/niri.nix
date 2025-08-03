{
  pkgs,
  pkgsUnstable,
  lib,
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
  programs.niri = {
    package = pkgs.niri_git;
    enable = true;
  };
  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
      xwayland-satellite # XWayland Integration
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome # required for screen-casting
      gnome-keyring # for secret management
      polkit_gnome # polkit agent
    ]
    ++ (with pkgsUnstable; [
      mako # notification daemon
      alacritty # terminal
      fuzzel # App Launcher
      waybar
      swaybg
      swaylock
      swayidle
    ]);

}
