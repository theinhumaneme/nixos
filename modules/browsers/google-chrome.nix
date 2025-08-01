{ pkgsUnstable, userName, ... }:
{

  users.users."${userName}".packages = with pkgsUnstable; [
    google-chrome
  ];

  fileSystems."/home/${userName}/.cache/google-chrome" = {
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
