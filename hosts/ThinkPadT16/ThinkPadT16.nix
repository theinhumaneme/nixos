{
  lib,
  pkgs,
  ...
}:
let
  userName = "kalyanm";
  enableChromeTmpfs = true;
  enableDocker = false;
  enableCTooling = true;
  enableJavaTooling = false;
  enableNodeJsTooling = false;
  enableRustTooling = true;
  enableDevTools = true;
in
{
  _module.args = {
    inherit
      userName
      enableDocker
      enableCTooling
      enableJavaTooling
      enableNodeJsTooling
      enableRustTooling
      enableDevTools
      ;

  };

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../users/user.nix
      ../../modules/gnome.nix
      ../../modules/sysctl-config.nix
      ../../modules/fish.nix
    ]
    ++ lib.optionals enableChromeTmpfs [ ../../modules/chome-cache-tmpfs.nix ] # google-chrome cache in tmpfs;
    ++ lib.optionals enableDocker [ ../../modules/docker.nix ]
    ++ lib.optionals enableCTooling [ ../../modules/c.nix ]
    ++ lib.optionals enableJavaTooling [ ../../modules/java.nix ]
    ++ lib.optionals enableNodeJsTooling [ ../../modules/nodejs.nix ]
    ++ lib.optionals enableRustTooling [ ../../modules/rust.nix ]
    ++ lib.optionals enableDevTools [ ../../modules/commonDevTools.nix ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Bootloader and Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "amdgpu.abmlevel=0"
    "rcutree.enable_rcu_lazy=1"
    "nowatchdog"
  ];
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "ThinkPadT16";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.nameservers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
  ];

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

  zramSwap = {
    enable = true;
  };

  hardware.graphics.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools

  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
