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
  programs = {
    niri = {
      package = pkgs.niri_git;
      enable = true;
    };
  };
  security.polkit.enable = true;
  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome # required for screen-casting
      gnome-keyring # for secret management
      polkit_gnome # polkit agent
    ]
    ++ (with pkgsUnstable; [
      xwayland-satellite # XWayland Integration
      mako # notification daemon
      alacritty # terminal
      walker
      waybar
      swaybg
      swaylock
      swayidle
      nautilus
      resources
      pavucontrol
      networkmanagerapplet
      swww
      brightnessctl
      papers
      loupe
      collision
      gnome-text-editor
    ]);
  #  home-manager.users."${userName}" = import ./home-gnome.nix { inherit pkgs pkgsUnstable; };

}
