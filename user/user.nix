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

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      extraCompatPackages = with pkgs; [
        proton-ge-custom
        proton-cachyos_x86_64_v3
        proton-cachyos_x86_64_v4
      ];
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
