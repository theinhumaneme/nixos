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
          tree
          openssl
          stow
        ]
        ++ (with pkgsUnstable; [
        ]);
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
      extraCompatPackages = with pkgs; [
        proton-ge-custom
        proton-cachyos_x86_64_v3
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
  home-manager.users."${userName}" = import ./home.nix { inherit pkgs pkgsUnstable; };

}
