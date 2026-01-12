{
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:
{
  programs = {
    obsidian = {
      enable = true;
      package = pkgsUnstable.obsidian;
    };
    aria2 = {
      enable = true;
      package = pkgsUnstable.aria2;
    };
    fastfetch = {
      enable = true;
      package = pkgsUnstable.fastfetch;
    };
    btop = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgsUnstable.btop else pkgsUnstable.btop-rocm;
    };
    discord = {
      enable = true;
      package = pkgsUnstable.discord;
    };
  };
}
