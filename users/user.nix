{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  userName,
  enableDevApps,
  enableDocker,
  enableJavaTooling,
  enableNodeJsTooling,
  enableCTooling,
  enableRustTooling,
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
      ] ++ lib.optionals enableDocker [ "docker" ];

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
        ])
        ++ (lib.optionals enableDevApps [
          # pkgsUnstable.zed-editor
          pkgsUnstable.vscode-fhs
          pkgsUnstable.github-desktop
          pkgsUnstable.lazygit
          pkgsUnstable.neovim
        ])
        ++ (lib.optionals enableDocker [
          docker_28
          pkgsUnstable.docker-compose
          pkgsUnstable.docker-buildx
        ])
        ++ (lib.optionals enableJavaTooling [
          jdk
          maven
        ])
        ++ (lib.optionals enableNodeJsTooling [
          nodejs_22
        ])
        ++ (lib.optionals enableCTooling [
          gcc
          clang
          cmake
          gnumake
          ninja
        ])
        ++ (lib.optionals enableRustTooling [
          pkgsUnstable.rustc
          pkgsUnstable.cargo
          pkgsUnstable.rust-analyzer
          pkgsUnstable.clippy
          pkgsUnstable.rustfmt
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
