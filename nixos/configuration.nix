{ config, pkgs, lib, ... }:

{
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Helsinki";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-old +42";
  };

  networking.networkmanager.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.valtteri = {
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  };

  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    vim
    wget
    curl
    git
  ];
}
