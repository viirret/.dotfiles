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
    zip
    unzip
    file
    python3
    openjdk
    sqlite
    docker
  ];
}
