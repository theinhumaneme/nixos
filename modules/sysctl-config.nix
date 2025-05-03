{ config, pkgs, ... }:

{
  # Add the tcp_bbr module for Google's BBR support
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    # Memory management
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    # Network
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
