{ userName, ... }:
{
  fileSystems."/home/${userName}/.cache/zen" = {
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
