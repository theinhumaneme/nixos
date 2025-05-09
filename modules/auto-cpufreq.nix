{
  pkgsUnstable,
  userName,
  ...
}:
{

  users.users."${userName}" = {

    packages = with pkgsUnstable; [
      auto-cpufreq
    ];
  };
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
      energy_performance_preference = "performance";
      platform_profile = "performance";
    };

    battery = {
      governor = "powersave";
      turbo = "never";
      energy_performance_preference = "power";
      platform_profile = "low-power";
    };
  };

}
