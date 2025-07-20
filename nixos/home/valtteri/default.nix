{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../fish.nix
    ../git.nix
    ../nvim.nix
    ../foot.nix
    ../sway.nix
    ../waybar.nix
  ];

  home.username = "valtteri";
  home.homeDirectory = "/home/valtteri";

  programs.git = {
    userName = "viirret";
    userEmail = "viirretvaltteri@gmail.com";
  };

  home.packages = with pkgs; [
    fira-code
    tree
    firefox
    fish
    i3
  ];
}
