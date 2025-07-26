{ ... }:
{
  imports = [
    ../../modules/pipewire/default.nix
    ../../modules/networking/default.nix
    ../../modules/xserver/wm.nix
    ../../modules/window-manager/i3/wm.nix
  ];
}
