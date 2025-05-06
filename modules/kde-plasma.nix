{ config, pkgs, ... }:
{

  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
  ];
}
