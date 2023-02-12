#!/usr/bin/env bash

# add packer
git clone https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/opt/packer.nvim

# add codedark
mkdir -p ~/.local/share/nvim/site/pack/themes/start
cd ~/.local/share/nvim/site/pack/themes/start
git clone https://github.com/tomasiser/vim-code-dark

