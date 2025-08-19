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
    ]
    ++ (with pkgsUnstable; [
      ddcutil # external display backlight management
    ]);
}
