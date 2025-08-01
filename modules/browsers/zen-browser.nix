{
  zen-browser,
  userName,
  pkgs,
  ...
}:
{

  # the system property is from the pkgs input
  users.users."${userName}".packages = [ zen-browser.packages.${pkgs.system}.default ];

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
