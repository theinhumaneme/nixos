{
  lib,
  userName,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  users.users."${userName}".packages = with pkgs; [ alejandra ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.ayu.enable = true;
    extraConfigLua = ''
      vim.g.slow_format_filetypes = vim.g.slow_format_filetypes or {}
      -- You can optionally pre-populate it with filetypes if you want.
      -- For example:
      -- vim.g.slow_format_filetypes.markdown = true
      -- vim.g.slow_format_filetypes.json = true
    '';
    globalOpts = {
      mouse = "a";
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      undofile = true;
      updatetime = 250;
      breakindent = true;
      cursorline = true;
      confirm = true;
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    plugins = {
      neo-tree = {
        enable = true;
      };
      web-devicons = {
        enable = true;
      };
      lualine = {
        enable = true;
      };
      bufferline = {
        enable = true;
      };
      conform-nvim = {
        enable = true;
        # Define slow_format_filetypes here as a global Lua table
        # This Lua code will be executed before your format_on_save/format_after_save functions.

        settings = {
          formatters_by_ft = {
            nix = [
              "nixfmt"
            ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                -- Access it via vim.g (global)
                if vim.g.slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                local function on_format(err)
                  if err and err:match("timeout$") then
                    -- Store it in vim.g (global)
                    vim.g.slow_format_filetypes[vim.bo[bufnr].filetype] = true
                  end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
              end
            '';
          format_after_save = # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                -- Access it via vim.g (global)
                if not vim.g.slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                return { lsp_fallback = true }
              end
            '';
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            nixfmt = {
              command = lib.getExe pkgs.nixfmt-rfc-style;
            };
            squeeze_blanks = {
              command = lib.getExe' pkgs.coreutils "cat"; # Note: cat is a no-op for squeeze_blanks, you might need a real formatter or script for this
            };
            trim_whitespace = {
              command = lib.getExe' pkgs.coreutils "sed"; # placeholder, this needs a specific sed command or a custom script
              args = [
                "-i"
                "s/\\s\\+$//g"
              ]; # Example for trimming trailing whitespace
            };
            trim_newlines = {
              command = lib.getExe' pkgs.coreutils "sed"; # placeholder, this needs a specific sed command or a custom script
              args = [
                "-i"
                "/^\\s*$/d"
              ]; # Example for trimming blank lines
            };
          };
        };
      };
    };
    lsp = {
      servers = {
        lua_ls = {
          enable = true;
        };
        nil_ls = {
          enable = true;
        };
      };
    };
  };
}
