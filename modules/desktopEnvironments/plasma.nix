{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.plasma.enable = lib.mkEnableOption "Plasma Desktop";

  config = lib.mkIf config.desktop.plasma.enable {
    services = {
      displayManager = {
        sddm.wayland.enable = true;
        sddm.enable = true;
      };
      desktopManager.plasma6.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      oxygen
      elisa
    ];
  };
}
