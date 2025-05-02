{
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
          btop-rocm
          gnome-power-manager
          android-tools
          nixfmt-rfc-style
          gnomeExtensions.dash2dock-lite
          gnomeExtensions.blur-my-shell
          docker_28
        ]
        ++ (with pkgsUnstable; [
          google-chrome
          obsidian
          zed-editor
          vscode-fhs
          github-desktop
          spotify
          aria
          mpv
          lazygit
          docker-compose
          docker-buildx

        ]);
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
