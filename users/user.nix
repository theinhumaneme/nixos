{
  pkgs,
  pkgsUnstable,
  userName,
  # zen-browser,
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
          gnome-power-manager
          android-tools
          stow
          nixfmt-rfc-style
          nixd
          nil
          wireguard-tools
        ]
        ++ (with pkgsUnstable; [
          obsidian
          spotify
          aria
          mpv
          power-profiles-daemon
          fastfetch
          transmission_4-gtk
          steam
          syncthing
          telegram-desktop
          stremio
          jellyfin-media-player
          firefox
          discord
          zoom-us
        ])
      # ++ [ zen-browser.packages."${system}".default ]
      ;
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting.autohint = true;
      hinting.enable = true;
      subpixel.lcdfilter = "light";
    };
  };

  fonts.packages = with pkgsUnstable; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  programs = {
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
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
