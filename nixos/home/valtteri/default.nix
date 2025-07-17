{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../fish.nix
    ../git.nix
    ../nvim.nix
  ];

  home.username = "valtteri";
  home.homeDirectory = "/home/valtteri";

  programs.git = {
    userName = "viirret";
    userEmail = "viirretvaltteri@gmail.com";
  };

  home.packages = with pkgs; [
    tree
    firefox
    alacritty
    fish
    i3
  ];
}
