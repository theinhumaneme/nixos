{ pkgs, ... }:
{
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

  boot.loader = {
    timeout = 0;
    systemd-boot = {
      enable = true;
      configurationLimit = 14;
    };
    efi.canTouchEfiVariables = true;
  };

  # Networking
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
