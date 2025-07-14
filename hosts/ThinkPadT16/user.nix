{
  pkgs,
  pkgsUnstable,
  userName,
  zen-browser,
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
          tree
          openssl
          btop-rocm
          gnome-power-manager
          android-tools
          stow
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
          telegram-desktop
          stremio
          jellyfin-media-player
          discord
          zoom-us
          gimp
        ])
        ++ [ zen-browser.packages."${system}".default ];
    };
  };

  fonts = {
    packages = with pkgsUnstable; [ nerd-fonts.fira-code ];
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting.autohint = true;
      hinting.enable = true;
      subpixel.lcdfilter = "light";
    };
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      extraCompatPackages = with pkgs; [ proton-ge-custom ];
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
  home-manager.users."${userName}" = import ./home.nix { inherit pkgs pkgsUnstable; };

}
