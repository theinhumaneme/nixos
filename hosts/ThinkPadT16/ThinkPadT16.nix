{
  pkgs,
  lib,
  userName,
  hostName,
  pkgsUnstable,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ../common/common.nix
    ../common/host-spec.nix
    ../../modules/bluetooth.nix
    ../../modules/sysctl-config.nix
    ./hardware-configuration.nix
    ./devConfig-nixos.nix
  ];

  hostSpec = {
    useSpecializations = false;
    defaultDesktop = "gnome";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit pkgsUnstable; };
  home-manager.users.${userName} = {
    imports = [
      ./devConfig-hm.nix
      ../common/fish.nix
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

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
