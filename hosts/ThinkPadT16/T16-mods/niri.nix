{
  pkgs,
  pkgsUnstable,
  userName,
  ...
}:
{
  users.users."${userName}".packages =
    # Apps
    with pkgs;
    [
    ]
    ++ (with pkgsUnstable; [
      brightnessctl # Manage Display Backlight
    ]);

}
