{ config, pkgs, lib, ... }:

{
  home.activation.removeOldNeovimConfig = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    rm -rf "${config.home.homeDirectory}/.config/nvim"
  '';
  home.activation.linkNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn "${config.home.homeDirectory}/.dotfiles/linux/.config/nvim" "${config.home.homeDirectory}/.config"
  '';

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      ripgrep

      # lsp
      clang-tools
      nil
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      python3Packages.python-lsp-server

      # formatting
      black
      ruff
      stylua
    ];
  };

}
