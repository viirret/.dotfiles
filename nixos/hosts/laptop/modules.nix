{ ... }:
{
  imports = [
    ../../modules/pipewire/default.nix
    ../../modules/networking/default.nix
    ../../modules/dbus/default.nix
    ../../modules/bluetooth/default.nix
    ../../modules/window-manager/hyprland/default.nix
    ../../modules/unfree/init.nix
  ];
}
