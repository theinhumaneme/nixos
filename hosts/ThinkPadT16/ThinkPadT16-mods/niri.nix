{
  pkgs,
  pkgsUnstable,
  userName,
  ...
}:
{
  imports = [ ../../../modules/desktopEnvironments/niri.nix ];
  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
      brightnessctl # Manage Display Backlight
    ]
    ++ (with pkgsUnstable; [

    ]);

}
