{ ... }:
{
  imports = [
    ./pipewire/default.nix
    ./networking/default.nix
    ./xserver/laptop.nix
    ./window-manager/i3/laptop.nix
  ];
}
