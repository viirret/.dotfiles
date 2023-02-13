#!/bin/bash

# get .dotfiles directory in a variable
dotfiles_dir=$(pwd)

# change to HOME
cd ~

# move all the files and directories to HOME
mv $dotfiles_dir/* .
