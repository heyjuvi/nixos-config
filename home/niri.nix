{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;
      ignore-empty-password = true;
      image = "~/.wallpapers/guberniya_blurred.png";
      font = "Monoid Nerd Font";
      font-size = "60";
      bs-hl-color = "ffffff00";
      caps-lock-bs-hl-color = "ffffff00";
      caps-lock-key-hl-color = "ffffff00";
      inside-color = "ffffff20";
      inside-clear-color = "ffffff80";
      inside-caps-lock-color = "ffffff20";
      inside-ver-color = "ffffff20";
      inside-wrong-color = "ffffff20";
      indicator-radius = "250";
      indicator-thickness = "3";
      key-hl-color = "d500baee";
      layout-bg-color = "ffffff20";
      layout-border-color = "ffffff20";
      layout-text-color = "00000080";
      line-color = "ffffff20";
      line-clear-color = "ffffff80";
      line-caps-lock-color = "ffffff00";
      line-ver-color = "ffffff20";
      line-wrong-color = "ff000080";
      ring-color = "ffffff20";
      ring-clear-color = "ffffff80";
      ring-caps-lock-color = "ffffff00";
      ring-ver-color = "ffffff20";
      ring-wrong-color = "ff202080";
      #separator-color = "d500baee";
      separator-color = "ffffff20";
      text-color = "000000A0";
      text-clear-color = "000000A0";
      text-caps-lock-color = "000000A0";
      text-ver-color = "000000A0";
      text-wrong-color = "00000080";
    };
  };

  programs.niri = {
    settings = {
      workspaces = {
        "chat" = { };
        "term" = { };
        "browser" = { };
        "music" = { };
      };
      animations.screenshot-ui-open = {
        easing = {
          curve = "ease-out-quad";
          duration-ms = 200;
        };
      };
      layer-rules = [
        {
          matches = [ { namespace = "^wallpaper$"; } ];
          place-within-backdrop = true;
        }
      ];
      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 5.0;
            bottom-right = 5.0;
            top-left = 5.0;
            top-right = 5.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [ { app-id = "^signal$"; } ];
          open-on-workspace = "chat";
        }
        {
          matches = [ { app-id = "^Element$"; } ];
          open-on-workspace = "chat";
        }
        {
          matches = [ { app-id = "^$nheko"; } ];
          open-on-workspace = "chat";
        }
        {
          matches = [ { app-id = "^discord$"; } ];
          open-on-workspace = "chat";
        }
        {
          matches = [ { app-id = "^org.telegram.desktop$"; } ];
          open-on-workspace = "chat";
        }
        {
          matches = [ { app-id = "^firefox$"; } ];
          open-on-workspace = "browser";
        }
        {
          matches = [ { app-id = "^floorp$"; } ];
          open-on-workspace = "browser";
        }
        {
          matches = [ { app-id = "^ghostty$"; } ];
          open-on-workspace = "term";
        }
        {
          matches = [ { app-id = "^spotify$"; } ];
          open-on-workspace = "music";
        }
      ];
      spawn-at-startup = [
        { command = [ "gnome-keyring-daemon" ]; }
	{
          command = [
            "swaybg"
            "-i"
            "${assets/wallpapers/musk-heavy-metal.png}"
            "-m"
            "fill"
          ];
        }	
        { command = [ "xwayland-satellite" ]; }
      ];
      environment = {
        DISPLAY = ":0";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      prefer-no-csd = true;
      /*
      outputs."eDP-1" = {
        mode = {
          width = 2880;
          height = 1800;
          refresh = 120.030;
        };
        scale = 2;
      };
      */
      input = {
        mod-key = "Super";
        mod-key-nested = "Alt";
        touchpad.natural-scroll = true;
        focus-follows-mouse.enable = true;
	keyboard = {
	  xkb = {
	   layout = "de";
	    variant = "neo";
	  };
	};
      };
      layout = {
        focus-ring.enable = false;
        background-color = "transparent";
        border = {
          enable = true;
          width = 4;
          active.gradient = {
            angle = 45;
            from = "oklch(0.8025 0.1203 226.51)";
            to = "oklch(0.8118 0.0912 6.32)";
            in' = "oklch longer hue";
          };
          inactive.gradient = {
            angle = 45;
            from = "oklch(0.8025 0.1203 226.51 / 40%)";
            to = "oklch(0.8118 0.0912 6.32 / 40%)";
            in' = "oklch longer hue";
          };
        };
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        preset-window-heights = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.; }
        ];
        default-column-width = {
          proportion = 0.5;
        };
        gaps = 6;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
      overview = {
        zoom = 0.3;
        # backdrop-color = "#0D1017";

      };
      binds =
        let
          actions = config.lib.niri.actions;
        in
        {
          "Mod+Shift+X".action.quit.skip-confirmation = false;
          "Mod+Return".action.spawn = "ghostty";
          "Mod+Backspace".action = actions.spawn "rofi" "-show" "drun";
          "Mod+Shift+Backspace".action = actions.spawn "rofi" "-show" "run";
          "Mod+Shift+Q".action = actions.close-window;
          "Mod+F11".action = actions.maximize-column;
          "Mod+Shift+F11".action = actions.fullscreen-window;
          "Mod+W".action = actions.switch-preset-column-width;
          "Mod+Shift+W".action = actions.switch-preset-window-height;
          "Mod+Shift+Space".action = actions.toggle-window-floating;
          "Mod+F".action = actions.toggle-overview;
          "Mod+Delete".action.spawn = "swaylock";
          "Mod+Shift+Slash".action = actions.show-hotkey-overlay;

          "Mod+2".action = actions.focus-workspace "chat";
          "Mod+3".action = actions.focus-workspace "term";
          "Mod+4".action = actions.focus-workspace "browser";
          "Mod+8".action = actions.focus-workspace "music";

          "Mod+S".action = actions.focus-column-left;
          "Mod+T".action = actions.focus-column-right;
          "Mod+R".action = actions.focus-window-or-workspace-up;
          "Mod+N".action = actions.focus-window-or-workspace-down;

          "Mod+Shift+S".action = actions.move-column-left;
          "Mod+Shift+T".action = actions.move-column-right;
          "Mod+Shift+R".action = actions.move-column-to-workspace-up;
          "Mod+Shift+N".action = actions.move-column-to-workspace-down;

          "Mod+Control+S".action = actions.swap-window-left;
          "Mod+Control+T".action = actions.swap-window-right;
          "Mod+Control+R".action = actions.move-window-up-or-to-workspace-up;
          "Mod+Control+N".action = actions.move-window-down-or-to-workspace-down;

          "Mod+Comma".action = actions.consume-or-expel-window-left;
          "Mod+Period".action = actions.consume-or-expel-window-right;

          "Print".action = actions.screenshot;
          "Mod+Shift+I".action = actions.screenshot-window {
            write-to-disk = true;
          };
          XF86AudioRaiseVolume = {
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1+"
            ];
            allow-when-locked = true;
          };
          XF86AudioLowerVolume = {
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1-"
            ];
            allow-when-locked = true;
          };
          XF86AudioMute = {
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
            allow-when-locked = true;
          };
          XF86AudioMicMute = {
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
            allow-when-locked = true;
          };
          # Brightness
          XF86MonBrightnessUp = {
            action.spawn = [
              "brightnessctl"
              "s"
              "+10%"
            ];
            allow-when-locked = true;
          };
          XF86MonBrightnessDown = {
            action.spawn = [
              "brightnessctl"
              "s"
              "10%-"
            ];
            allow-when-locked = true;
          };
        };
    };
  };
}

