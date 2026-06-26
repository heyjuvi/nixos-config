{ config, pkgs, ... }: {

  imports = [
  ];

  # Shell
  programs.bash.enable = true;

  # Prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };

  # Commandline Tools
  programs.htop.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      tab_bar_edge = "bottom";
      tab_bar_style = "slant";
      hide_window_decorations = true;
      window_margin_width = 10;
      background_blur = 1;
      notify_on_cmd_finish = "invisible";
      cursor_trail = 1;
    };
  };

  stylix.targets.kitty = {
    fonts.override = {
      package = pkgs.fira-code;
      name = "Maple Mono";
      size = 12.0;
    };
  };

  stylix.opacity.terminal = 0.6;

  programs.zsh = {
    enable = true;
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

  programs.zsh.shellAliases = {
    ssh = "kitten ssh";
  };
}
