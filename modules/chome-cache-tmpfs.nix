{
  config,
  pkgs,
  userName,
  ...
}:
{
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
