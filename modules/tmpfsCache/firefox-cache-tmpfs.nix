{ userName, ... }: {
  fileSystems."/home/${userName}/.cache/mozilla/firefox" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "noatime" "nodev" "nosuid" "size=2G" ];
  };
}
