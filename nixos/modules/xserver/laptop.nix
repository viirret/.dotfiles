{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "fi";
  };
}
