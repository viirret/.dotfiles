{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "hyprland/workspaces"
        ];

        modules-center = [
          "sway/window"
          "hyprland/window"
        ];

        modules-right = [
          "battery"
          "clock"
        ];
      };
    };
  };
}
