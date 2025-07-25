{ ... }:
{
  imports = [
    ./pipewire/default.nix
    ./networking/default.nix
    ./dbus/default.nix
    ./bluetooth/default.nix
    ./window-manager/hyprland/default.nix
  ];

  my.bluetooth.enable = true;
  my.bluetooth.user = "valtteri";
}
