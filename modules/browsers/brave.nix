{ pkgsUnstable, userName, ... }:
{

  users.users."${userName}".packages = with pkgsUnstable; [
    brave
  ];

  fileSystems."/home/${userName}/.cache/BraveSoftware" = {
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
