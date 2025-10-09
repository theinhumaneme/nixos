{ pkgs, pkgsUnstable, ... }:
{
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
}
