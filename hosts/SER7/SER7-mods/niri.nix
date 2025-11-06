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
      ddcutil # external display backlight management
    ]
    ++ (with pkgsUnstable; [

    ]);
}
