{ pkgs, pkgsUnstable, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgsUnstable.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    #    iconTheme = {
    #      package = pkgsUnstable.papirus-icon-theme;
    #      name = "Papirus-Dark";
    #    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      monospace-font-name = "FiraCode Nerd Font Mono Medium 11";
    };
  };

  home.stateVersion = "25.05";
}
