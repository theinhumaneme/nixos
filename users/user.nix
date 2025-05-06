{
  lib,
  config,
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
          gnomeExtensions.dash2dock-lite
          gnomeExtensions.blur-my-shell
          nixd
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
        ]);
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
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
