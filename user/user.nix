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
          openssl
          stow
          tree
        ]
        ++ (with pkgsUnstable; [
        ]);
    };
  };

  fonts = {
    packages = with pkgsUnstable; [
      adwaita-fonts
      nerd-fonts.caskaydia-mono
    ];
    fontconfig = {
      enable = true;
      hinting.autohint = true;
      hinting.enable = true;
      subpixel.lcdfilter = "light";
      subpixel.rgba = "rgb";
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
  #  home-manager.users."${userName}" = import ./home.nix { inherit pkgs pkgsUnstable; };

}
