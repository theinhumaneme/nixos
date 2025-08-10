{ lib, pkgs, ... }:
let
  userName = "kalyanm";
  hostName = "ThinkPadT16";
  enableAutoCpuFreq = true;
  enableCTooling = true;
  enableDevTools = true;
  enableDocker = false;
  enableJavaTooling = false;
  enableNeoVim = true;
  enableNodeJsTooling = false;
  enableRustTooling = true;
  enableTLP = false;
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
      ;

  };

  imports = [
    # Include the results of the hardware scan.
    ../../hosts/common.nix
    ../../modules/bluetooth.nix
    ../../modules/browser.nix
    ../../modules/desktopEnvironments/fish.nix
    ../../modules/desktopEnvironments/niri.nix
    ../../modules/sysctl-config.nix
    ./hardware-configuration.nix
    ./user-apps.nix
    ./user.nix
  ]
  ++ lib.optionals enableAutoCpuFreq [ ../../modules/auto-cpufreq.nix ]
  ++ lib.optionals enableCTooling [ ../../modules/devStuff/c.nix ]
  ++ lib.optionals enableDevTools [ ../../modules/devStuff/common.nix ]
  ++ lib.optionals enableDocker [ ../../modules/devStuff/docker.nix ]
  ++ lib.optionals enableJavaTooling [ ../../modules/devStuff/java.nix ]
  ++ lib.optionals enableNeoVim [ ../../modules/devStuff/neovim/neovim.nix ]
  ++ lib.optionals enableNodeJsTooling [ ../../modules/devStuff/nodejs.nix ]
  ++ lib.optionals enableRustTooling [ ../../modules/devStuff/rust.nix ]
  ++ lib.optionals enableTLP [ ../../modules/tlp.nix ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  boot.kernelParams = [
    "amd_pstate=guided"
    "amdgpu.abmlevel=0"
    "nowatchdog"
    "quiet"
    "rcutree.enable_rcu_lazy=1"
    "splash"
  ];

  # Networking
  networking.hostName = hostName;
  networking.nameservers = [
    "192.168.1.183"
  ];

  # Enable Fingerprint Support
  services.fprintd.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
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
