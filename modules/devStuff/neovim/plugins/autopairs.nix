{ ... }:
{
  programs.nixvim = {
    plugins.nvim-autopairs = {
      enable = true;
      settings = {
      };
    };

  };
} # https://nix-community.github.io/nixvim/plugins/nvim-autopairs/index.html
