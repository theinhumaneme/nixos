{ pkgsUnstable, userName, ... }:
{
  users.users."${userName}".packages = with pkgsUnstable; [
    firefox
  ];
  fileSystems."/home/${userName}/.cache/mozilla/firefox" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "noatime"
      "nodev"
      "nosuid"
      "size=2G"
    ];
  };
}
