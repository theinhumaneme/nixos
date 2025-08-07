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

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    lazy-trees = true;
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
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx = {
    package = pkgs.scx_git.full;
    enable = true;
    scheduler = "scx_lavd";
    extraArgs = [ "--autopower" ];
  };

  boot.kernelParams = [
    "amd_pstate=guided"
    "amdgpu.abmlevel=0"
    "nowatchdog"
    "quiet"
    "rcutree.enable_rcu_lazy=1"
    "splash"
  ];
  boot.loader = {
    timeout = 0;
    systemd-boot = {
      enable = true;
      configurationLimit = 14;
    };
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = [
    pkgs.networkmanager-fortisslvpn
    pkgs.networkmanager-iodine
    pkgs.networkmanager-l2tp
    pkgs.networkmanager-openconnect
    pkgs.networkmanager-openvpn
    pkgs.networkmanager-sstp
    pkgs.networkmanager-strongswan
    pkgs.networkmanager-vpnc
  ];
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;
  networking.nameservers = [
    "192.168.1.183"
    "1.0.0.1#one.one.one.one"
    "1.1.1.1#one.one.one.one"
    "2606:4700:4700::1001#one.one.one.one"
    "2606:4700:4700::1111#one.one.one.one"
  ];

  networking.networkmanager.dns = "systemd-resolved";
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "8.8.8.8"
      "2001:4860:4860::8844"
    ];
  };

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

  zramSwap = {
    enable = true;
  };

  hardware.graphics.enable = true;

  # enable Chaotic NYX beelding edge Mesa Drivers
  chaotic.mesa-git.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # https://nixos.org/manual/nixos/stable/options#opt-system.rebuild.enableNg
  system.rebuild.enableNg = true;

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    busybox
    fwupd
    pciutils
    usbutils
    lm_sensors
    smartmontools
  ];
  services.fwupd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
