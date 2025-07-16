{ config, pkgs, ... }:

{
  imports = [
    ../fish.nix
  ];

  home.stateVersion = "23.11";
  home.username = "valtteri";
  home.homeDirectory = "/home/valtteri";

  programs = {
    git = {
      enable = true;
      userName = "viirret";
      userEmail = "viirretvaltteri@gmail.com";

      ignores = [
        ".env"
      ];
    };
  };

  home.packages = with pkgs; [
    tree
    firefox
    alacritty
    fish
    i3
  ];
}
