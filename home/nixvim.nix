{ config, pkgs, inputs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    extraConfigLua = builtins.readFile ./config-files/nvim/init.lua; 
    
    clipboard.providers.wl-copy.enable = true;
    colorschemes.catppuccin.enable = true;

    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    };

    plugins = {
      lualine.enable = true;
      gitsigns.enable = true;
      fugitive.enable = true;
      cursorline.enable = true;
      telescope.enable = true;
      which-key.enable = true;
      noice.enable = true;
      notify.enable = true;
      luasnip.enable = true;
      neo-tree.enable = true;
      crates-nvim.enable = true;
      fidget.enable = true;
      bufferline.enable = true;

      alpha = {
        enable = true;
        theme = "startify";
      };

      lsp-format = {
        enable = true;
      };

      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          clangd.enable = true;
          tsserver.enable = true;
          eslint.enable = true;
          nil-ls.enable = true;

          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      treesitter = {
        enable = true;
	settings = {
          indent.enable = true;
	};
        nixvimInjections = true;
      };

      treesitter-refactor = {
        enable = true;
        smartRename.enable = true;
        highlightCurrentScope.enable = true;
        navigation.enable = true;
      };
    };

    keymaps =
      [
        {
          mode = "n";
          key = "<leader>ff";
          options.silent = true;
          action = "<cmd>Telescope file_browser<CR>";
        }
        {
          mode = "n";
          key = "<leader>bb";
          options.silent = true;
          action = "<cmd>Telescope buffers<CR>";
        }
        {
          mode = "n";
          key = "<leader>Gp";
          action = "<cmd>Git pull<CR>";
        }
        {
          mode = "n";
          key = "<leader>GP";
          action = "<cmd>Git push<CR>";
        }
        {
          mode = "n";
          key = "<leader>Gc";
          action = "<cmd>Git commit<CR>";
        }
        {
          mode = "n";
          key = "<leader>Ga";
          action = "<cmd>Git add .<CR>";
        }
        {
          mode = "n";
          key = "<leader>Gd";
          action = "<cmd>Git diff<CR>";
        }
        {
          mode = "n";
          key = "<leader>nt";
          action = "<cmd>Neotree toggle left<CR>";
        }
        {
          mode = "n";
          key = "<leader>P";
          action = "\"+p";
        }
        {
          mode = [ "n" "v" ];
          key = "<leader>y";
          action = "[[\"+y]]";
        }
        {
          mode = [ "n" ];
          key = "<leader>Y";
          action = "[[\"+Y]]";
        }
      ];
  };
}
