{ lib, pkgsUnstable, userName, enableDevTools, ... }: {
  users.users."${userName}".packages = (lib.optionals enableDevTools
    (with pkgsUnstable; [
      # zed-editor-fhs
      neovim
      lazygit
      ripgrep
      tmux
      wl-clipboard
      # dbeaver-bin
      # postman
      # github-desktop

    ]));
}
