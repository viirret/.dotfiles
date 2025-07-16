{ config, pkgs, ... };

{
  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  services.openssh.enable = true;
}
