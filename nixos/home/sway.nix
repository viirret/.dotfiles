{ config, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wofi --show drun";

      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+q" = "kill";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -b 'Yes' 'swaymsg exit'";
        "${modifier}+r" = "mode resize";
      };
    };
    extraConfig = ''
      input * {
        xkb_layout "fi"
      }

      bar {
          position top
          status_command waybar
      }
      exec "export XDG_RUNTIME_DIR=/run/user/$(id -u)"
      exec "export WAYLAND_DISPLAY=wayland-1"
    '';
  };

  home.packages = with pkgs; [
    dbus
    swaylock
    swayidle
    wl-clipboard
    grim
    slurp

    foot
    waybar
    wofi
    mako

    mesa
    vulkan-tools
    libva-utils
  ];

  # Environment variables for Wayland compatibility
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1"; # Firefox on Wayland
    QT_QPA_PLATFORM = "wayland"; # Qt apps on Wayland
    SDL_VIDEODRIVER = "wayland"; # SDL games on Wayland
    XDG_CURRENT_DESKTOP = "sway"; # Helps some apps recognize Sway

    LIBVA_DRIVER_NAME = "radeonsi";
    GBM_BACKEND = "radeonsi";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  systemd.user.services = {
    sway-session = {
      Unit = {
        Description = "Sway compositor session";
        Requires = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target " ];
      };
      Service = {
        ExecStart = "${pkgs.sway}/bin/sway";
        Restart = "on-failure";
      };
    };
  };
}
