{ config, pkgs, ... }:

{
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  unfree = {
    enable = true;
  };

  my.bluetooth.enable = true;
  my.bluetooth.user = "valtteri";

  hardware.firmware = [ pkgs.linux-firmware ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  boot.supportedFilesystems = [ "ext4" "vfat" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.acpid.enable = true;
  environment.systemPackages = with pkgs; [
    discord
    acpi
    acpid
  ];

  systemd.services.turn-on-keyboard-backlight = {
    description = "Turn on ASUS Keyboard Backlight";
    wantedBy = [ "multi-user.target" ];
    script = ''
      echo 3 > /sys/class/leds/asus::kbd_backlight/brightness
    '';
  };

}
