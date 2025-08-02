{
  pkgsUnstable,
  ...
}:
{
  home.packages = with pkgsUnstable; [ profile-sync-daemon ];
  services.psd = {
    enable = false;
    resyncTimer = "5min";
  };

}
