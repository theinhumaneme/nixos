{ pkgs, lib, ... }:
let
  userName = "kalyanm";
  hostName = "ThinkPadT16";
in
{
  _module.args = {
    inherit
      userName
      ;
  };

  imports = [
    # Include the results of the hardware scan.
    ../../hosts/common/common.nix
    ../../modules/bluetooth.nix
    ../../modules/browser.nix
    ../../modules/desktopEnvironments/fish.nix
    ../../modules/desktopEnvironments/gnome.nix
    ../../modules/sysctl-config.nix
    ../../user/user-apps.nix
    ./../../user/user.nix
    ./hardware-configuration.nix
  ];
  # Set your time zone.
  time.timeZone = "America/New_York";

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-gcc;

    kernelParams = [
      "amd_pstate=guided"
      "amdgpu.abmlevel=0"
      "nowatchdog"
      "quiet"
      "rcutree.enable_rcu_lazy=1"
      "splash"
    ];
  };

  # Networking
  networking.hostName = hostName;

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
