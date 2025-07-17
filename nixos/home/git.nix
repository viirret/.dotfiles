{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [ ".env" ];
  };
}
