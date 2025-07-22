{ config, lib, pkgs, ... }:

let
  cfg = config.my.bluetooth;
in
{
  options.my.bluetooth = {
    enable = lib.mkEnableOption "Enable basic system-wide Bluetooth support with CLI tools";

    user = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Username to add to the bluetooth group for permission to control Bluetooth.";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    environment.systemPackages = with pkgs; [
      bluez
    ];
  };
}

