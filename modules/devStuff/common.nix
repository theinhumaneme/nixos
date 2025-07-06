{ lib, pkgsUnstable, userName, enableDevTools, ... }: {
  users.users."${userName}".packages = (lib.optionals enableDevTools
    (with pkgsUnstable; [
      # zed-editor-fhs
      neovim
      lazygit
      ripgrep
      # dbeaver-bin
      # postman
      # github-desktop

    ]));
}
