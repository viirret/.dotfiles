{ config, pkgs, lib, ... }:
let
  i3Config = pkgs.writeText "i3-config" ''
    set $mod Mod1
    bindsym $mod+Return exec ${pkgs.alacritty}/bin/alacritty
    bindsym $mod+d exec ${pkgs.rofi}/bin/rofi -show run
    bindsym $mod+q kill
  '';
in
{
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    configFile = i3Config;
    extraPackages = with pkgs; [
      i3status
      rofi
    ];
  };
}
