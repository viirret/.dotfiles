{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
  };
}
