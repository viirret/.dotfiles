{ config, pkgs, ... }:

{
  imports = [
    ../default.nix
    ./packages.nix
  ];

  home.username = "valtteri";
  home.homeDirectory = "/home/valtteri";

  programs.git.settings.user = {
    name = "viirret";
    email = "viirretvaltteri@gmail.com";
  };
}
