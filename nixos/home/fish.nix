{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      set -U fish_greeting
      set -gx EDITOR vim
    '';

    interactiveShellInit = ''
      fish_vi_key_bindings
    '';

    functions = {
      mkcd.body = ''
        mkdir $argv && cd $argv
      '';
    };
  };
}
