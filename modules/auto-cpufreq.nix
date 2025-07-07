{ pkgsUnstable, userName, ... }:
{

  users.users."${userName}" = {

    packages = with pkgsUnstable; [ auto-cpufreq ];
  };
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "schedutil";
      turbo = "always";
      energy_performance_preference = "performance";
      platform_profile = "performance";
    };

    battery = {
      governor = "schedutil";
      turbo = "auto";
      energy_performance_preference = "balance_power";
      platform_profile = "balanced";
    };
  };

}
