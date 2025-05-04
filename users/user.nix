{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  userName,
  enableDevApps,
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
          btop-rocm
          gnome-power-manager
          android-tools
          stow
          nixfmt-rfc-style
          gnomeExtensions.dash2dock-lite
          gnomeExtensions.blur-my-shell
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
        ])
        ++ (lib.optionals enableDevApps [
          # pkgsUnstable.zed-editor
          pkgsUnstable.vscode-fhs
          pkgsUnstable.github-desktop
          pkgsUnstable.lazygit
          pkgsUnstable.neovim
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
