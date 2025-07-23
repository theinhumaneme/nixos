{ pkgs, ... }:

{
  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        # --- General ---
        # Set the default mode. AC prioritizes performance.
        TLP_DEFAULT_MODE = "AC";

        # --- CPU Settings ---
        # On AC Power (Performance)
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_BOOST_ON_AC = "1"; # 1 = enabled.
        PLATFORM_PROFILE_ON_AC = "performance";

        # On Battery Power (Max Savings)
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_BOOST_ON_BAT = "0"; # 0 = Disabled.
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # --- Aggressive Power Saving Options ---

        # Runtime Power Management for PCIe devices.
        # This allows devices to enter low-power states when not in active use.
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto"; # "auto" enables runtime PM for all supported devices.

        # Sound Chipset Power Saving
        # Puts the audio controller into a power-save mode after 1 second of inactivity.
        # Note: On some systems, this can cause a slight popping sound when audio starts/stops.
        SOUND_POWER_SAVE_ON_BAT = "1";
        SOUND_POWER_SAVE_CONTROLLER = "Y";

        # --- AMD Radeon 780M Graphics ---
        # Manages power for your integrated GPU.
        RADEON_POWER_PROFILE_ON_AC = "high";
        RADEON_POWER_PROFILE_ON_BAT = "low"; # "low" is the most power-efficient setting.

        # --- PCIe & NVMe ---
        # Enables Active State Power Management (ASPM) for PCIe devices, including your NVMe SSD.
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersupersave"; # "powersupersave" is the most aggressive setting.

        # --- Wi-Fi Power Saving ---
        # Note: This can sometimes reduce throughput or increase latency.
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        # Allow USB devices to enter a suspended state when idle.
        USB_AUTOSUSPEND = "1";
      };
    };
  };
  environment.systemPackages = [ pkgs.tlp ];
}
