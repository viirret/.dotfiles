{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "fi";
    videoDrivers = [ "amdgpu" ];
  };
}
