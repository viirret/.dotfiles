{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    fira-code
    tree
    firefox
    fish
    i3
    qbittorrent
  ];
}
