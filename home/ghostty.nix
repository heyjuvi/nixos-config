{ config, pkgs, inputs, lib, ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-size = 14;
      background-opacity = 0.8;
      window-decoration = false;
    };
  };
}
