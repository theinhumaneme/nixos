{
  lib,
  pkgs,
  pkgsUnstable,
  userName,
  enableZedEditor,
  ...
}:
lib.mkIf enableZedEditor {
  programs = {
    zed-editor = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgsUnstable.zed-editor else pkgsUnstable.zed-editor-fhs;
    };
  };
  home.packages = [
    pkgs.nixfmt
    pkgs.kdlfmt
    pkgs.prettier
  ];
}
