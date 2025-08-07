{ pkgsUnstable, userName, ... }:
{

  users.users."${userName}" = {

    packages = with pkgsUnstable; [ auto-cpufreq ];
  };
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "always";
      platform_profile = "performance";
    };

    battery = {
      governor = "schedutil";
      turbo = "auto";
      platform_profile = "balanced";
    };
  };

}
