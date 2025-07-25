{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
      enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    GBM_BACKEND = "radeonsi";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    libva-utils
    glxinfo
  ];
}
