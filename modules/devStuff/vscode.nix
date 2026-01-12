{
  lib,
  pkgs,
  pkgsUnstable,
  userName,
  enableVSCode,
  ...
}:
lib.mkIf enableVSCode {
  programs = {
    vscode = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgsUnstable.vscode else pkgsUnstable.vscode-fhs;
    };
  };
  home.packages = [
    pkgs.nixfmt
    pkgs.kdlfmt
  ];
}
