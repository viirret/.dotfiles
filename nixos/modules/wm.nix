{ ... }:
{
  imports = [
    ./pipewire/default.nix
    ./networking/default.nix
    ./xserver/wm.nix
    ./window-manager/i3/wm.nix
  ];
}
