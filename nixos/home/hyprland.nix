{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = false;
    extraConfig = builtins.readFile ./hyprland/hyprland.lua;
  };

  home.packages = with pkgs; [
    foot
    firefox
    wofi
    wl-clipboard
    swaylock
    swayidle
    mako
    grim
    slurp
    swaybg
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };
}
