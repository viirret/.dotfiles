{ config, pkgs, ... }:

{
  imports = [
    ../default.nix
    ./packages.nix
  ];

  home.username = "valtteri";
  home.homeDirectory = "/home/valtteri";

  programs.git = {
    userName = "viirret";
    userEmail = "viirretvaltteri@gmail.com";
  };
}
