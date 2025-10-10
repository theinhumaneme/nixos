{
  pkgs,
  lib,
  config,
  ...
}:
let
  userName = "kalyanm";
  hostName = "SER7";
  enableAutoCpuFreq = false;
  enableCTooling = true;
  enableDevTools = true;
  enableDocker = true;
  enableJavaTooling = false;
  enableNeoVim = false;
  enableNodeJsTooling = false;
  enableRustTooling = false;
  enableTLP = false;
  enableZedEditor = false;
  enableVSCode = true;
in
{
  _module.args = {
    inherit
      userName
      enableCTooling
      enableDevTools
      enableDocker
      enableJavaTooling
      enableNodeJsTooling
      enableRustTooling
      enableZedEditor
      enableVSCode
      ;

  };

  imports = [
    # Include the results of the hardware scan.
    ../../hosts/common.nix
    ../../modules/bluetooth.nix
    ../../modules/browser.nix
    ../../modules/desktopEnvironments/fish.nix
    ../../modules/desktopEnvironments/gnome.nix
    # ./SER7-mods/niri.nix
    ../../modules/sysctl-config.nix
    ../../user/user-apps.nix
    ./../../user/user.nix
    ./hardware-configuration.nix
  ]
  ++ lib.optionals enableAutoCpuFreq [ ../../modules/auto-cpufreq.nix ]
  ++ lib.optionals enableCTooling [ ../../modules/devStuff/c.nix ]
  ++ lib.optionals enableDevTools [ ../../modules/devStuff/common.nix ]
  ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ]
  ++ lib.optionals enableJavaTooling [ ../../modules/devStuff/java.nix ]
  ++ lib.optionals enableNeoVim [ ../../modules/devStuff/neovim/neovim.nix ]
  ++ lib.optionals enableNodeJsTooling [ ../../modules/devStuff/nodejs.nix ]
  ++ lib.optionals enableRustTooling [ ../../modules/devStuff/rust.nix ]
  ++ lib.optionals enableTLP [ ../../modules/tlp.nix ]
  ++ lib.optionals enableZedEditor [ ../../modules/devStuff/zed.nix ]
  ++ lib.optionals enableVSCode [ ../../modules/devStuff/vscode.nix ];
  # Set your time zone.
  time.timeZone = "America/New_York";

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-gcc;

    kernelParams = [
      "amd_pstate=guided"
      "nowatchdog"
      "quiet"
      "splash"
    ];
  };

  # ===================================== #
  # External Display Backlight Management
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
  boot.kernelModules = [
    "i2c-dev"
    "ddcci_backlight"
  ];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  users.users."${userName}".extraGroups = [ "i2c" ];
  # ===================================== #

  # Networking
  networking.hostName = hostName;

  # Enable Fingerprint Support
  services.fprintd.enable = false;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = userName;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
    NetworkManager-wait-online.enable = false;
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
