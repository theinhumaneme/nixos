{ pkgs, ... }:
{
  imports = [ ../modules/desktopEnvironments/fish.nix ];
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://install.determinate.systems"
        "https://chaotic-nyx.cachix.org/"
      ];
      trusted-public-keys = [
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      lazy-trees = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
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
  };
  # Bootloader and Kernel
  boot = {
    loader = {
      timeout = 0;
      systemd-boot = {
        enable = true;
        configurationLimit = 14;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    enableIPv6 = false;
    nameservers = [
      "1.0.0.1"
      "1.1.1.1"
      "2606:4700:4700::1001"
      "2606:4700:4700::1111"
    ];
    firewall = {
      enable = true;
      checkReversePath = false;
    };
    networkmanager = {
      enable = true;
      # dns = "systemd-resolved";
      plugins = [
        pkgs.networkmanager-fortisslvpn
        pkgs.networkmanager-iodine
        pkgs.networkmanager-l2tp
        pkgs.networkmanager-openconnect
        pkgs.networkmanager-openvpn
        pkgs.networkmanager-sstp
        pkgs.networkmanager-strongswan
        pkgs.networkmanager-vpnc
      ];
    };
  };

  # Services
  services = {
    scx = {
      package = pkgs.scx.full;
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--autopower" ];
    };
    pulseaudio.enable = false;

    pipewire = {
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
    fwupd.enable = true;
    upower.enable = true;
  };

  zramSwap = {
    enable = true;
  };

  hardware.graphics.enable = true;

  # enable Chaotic NYX beelding edge Mesa Drivers
  chaotic.mesa-git.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  # https://nixos.org/manual/nixos/stable/options#opt-system.rebuild.enableNg
  system.rebuild.enableNg = true;

  environment.systemPackages = with pkgs; [
    busybox
    fwupd
    lm_sensors
    mesa-demos
    pciutils
    smartmontools
    usbutils
    vulkan-tools
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
