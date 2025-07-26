{ config, pkgs, ... }:
{
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "virtual-nixos";
}
