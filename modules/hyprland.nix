{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  userName,
  ...
}:
{

  users.users."${userName}" = {

    extraGroups = [
      "seat"
      "video"
      "input"
    ];

    packages = with pkgs; [
      hyprpaper # wallpaper manager
      rofi-wayland # application launcher
      waybar # status panel
      swaynotificationcenter # for notifications
      xdg-desktop-portal-hyprland # to enable streaming
      hyprpolkitagent # for authentication
      libsForQt5.qt5.qtwayland
      kdePackages.qtwayland
      kitty
      vulkan-tools
      mesa-demos
      brightnessctl
    ];
  };
  security.polkit.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.seatd.enable = true;
  services.power-profiles-daemon.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

}
