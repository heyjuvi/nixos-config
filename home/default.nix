{ config, pkgs, inputs, lib, ... }:
{
  imports =
    [
      ./shell.nix
      ./nixvim.nix
      ./niri.nix
      ./ghostty.nix
    ];

  home.username = "juvi";
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = with pkgs;
   [
      niri
      xwayland-satellite
      swaybg
      firefox
      telegram-desktop
      signal-desktop
      gcc
      cargo
      tree
      btop
      tofi
      rofi
      zathura
      tty-clock
      sway-contrib.grimshot
      neovide
      openvpn
      swww
      brightnessctl
      discord
      remmina
      inkscape
      gimp
      qemu
      prusa-slicer
      ghostty
      gnome-boxes
      dolphin-emu
      eog
      docker-compose
      python311
      python311Packages.pillow
      nerd-fonts._0xproto
      nerd-fonts._3270
      nerd-fonts.agave
      nerd-fonts.anonymice
      nerd-fonts.arimo
      nerd-fonts.aurulent-sans-mono
      nerd-fonts.bigblue-terminal
      nerd-fonts.bitstream-vera-sans-mono
      nerd-fonts.blex-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
      nerd-fonts.code-new-roman
      nerd-fonts.comic-shanns-mono
      nerd-fonts.commit-mono
      nerd-fonts.cousine
      nerd-fonts.d2coding
      nerd-fonts.daddy-time-mono
      nerd-fonts.departure-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.envy-code-r
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.geist-mono
      nerd-fonts.go-mono
      nerd-fonts.gohufont
      nerd-fonts.hack
      nerd-fonts.hasklug
      nerd-fonts.heavy-data
      nerd-fonts.hurmit
      nerd-fonts.im-writing
      nerd-fonts.inconsolata
      nerd-fonts.inconsolata-go
      nerd-fonts.inconsolata-lgc
      nerd-fonts.intone-mono
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
      nerd-fonts.jetbrains-mono
      nerd-fonts.lekton
      nerd-fonts.liberation
      nerd-fonts.lilex
      nerd-fonts.martian-mono
      nerd-fonts.meslo-lg
      nerd-fonts.monaspace
      nerd-fonts.monofur
      nerd-fonts.monoid
      nerd-fonts.mononoki
      nerd-fonts.noto
      nerd-fonts.open-dyslexic
      nerd-fonts.overpass
      nerd-fonts.profont
      nerd-fonts.proggy-clean-tt
      nerd-fonts.recursive-mono
      nerd-fonts.roboto-mono
      nerd-fonts.shure-tech-mono
      nerd-fonts.sauce-code-pro
      nerd-fonts.space-mono
      nerd-fonts.symbols-only
      nerd-fonts.terminess-ttf
      nerd-fonts.tinos
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans
      nerd-fonts.victor-mono
      nerd-fonts.zed-mono
    ];

  programs.git = {
    enable = true;
    userName = "misterdanb";
    userEmail = "danb@ha.si";

    aliases = {
      alias = "!git config --get-regexp alias | sed 's/alias\\.\\([^ ]*\\) /\\1 := /'";
      graph = "log --graph --decorate --oneline";
      map = "!git graph --all";
      watch = "!watch -ct 'git -c color.status=always status -s && echo && git map --color'";
    };

    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      fetch.prune = true;
    };
  };

  programs.home-manager.enable = true;

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
  };

  home.pointerCursor =
    let
      chooseCursor = name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        package = pkgs.runCommand "cursorTheme" {} ''
          mkdir -p $out/share/icons
          cp -r ${./assets/cursors}/${name} $out/share/icons/${name}
        '';
      };
    in
      chooseCursor "plan9";

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["pwmt.zathura-cb.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["pwmt.zathura-cb.desktop"];
    };
  };

  #home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";

  home.stateVersion = "23.11";
}
