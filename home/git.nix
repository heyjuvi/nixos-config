
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "linn";
      user.email = "linn@ha.si";

      pull.rebase = true;
      init.defaultBranch = "main";
      fetch.prune = true;
    };
  };
}

