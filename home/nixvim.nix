{ config, pkgs, inputs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    clipboard.providers.wl-copy.enable = true;
    colorschemes.catppuccin.enable = true;

    opts = {
      number = true;          # Show line numbers
      relativenumber = false; # Show relative line numbers
      shiftwidth = 2;         # Tab width should be 2
    };

    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      gitsigns.enable = true;
      cursorline.enable = true;
      telescope.enable = true;
      noice.enable = true;
      neo-tree.enable = true;

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
          clangd.enable = true;

          rust_analyzer = {
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
  };
}
