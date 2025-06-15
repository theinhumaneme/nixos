{
  pkgs,
  pkgsUnstable,
  userName,
  ...
}:
{
  users.users = {
    "${userName}" = {
      isNormalUser = true;
      description = "Kalyan Mudumby";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];

      packages =
        with pkgs;
        [
          git
          tree
          openssl
          btop-rocm
          gnome-power-manager
          android-tools
          stow
          nixfmt-rfc-style
          nixd
          nil
          wireguard-tools
        ]
        ++ (with pkgsUnstable; [
          google-chrome
          obsidian
          spotify
          aria
          mpv
          power-profiles-daemon
          fastfetch
          tmux
          transmission_4-gtk
          newsflash
          steam
          syncthing
          telegram-desktop
        ]);
    };
  };

  fonts.packages = with pkgsUnstable; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # Install firefox.
  programs = {
    firefox.enable = false;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    };
  };
  services = {
    syncthing = {
      enable = true;
      user = userName;
      openDefaultPorts = true;
      dataDir = "/home/${userName}";
      configDir = "/home/${userName}/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
}
