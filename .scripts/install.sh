#!/usr/bin/env bash

# Get .dotfiles and HOME directories.
src_dir=$(pwd)
dst_dir=~

# Don't copy these files to HOME directory.
skip_files=(".git" ".gitignore" ".gitmodules" "README.md")

# Copy all the files from src to dst.
for file in "$src_dir"/.[^.]*; do
    filename=$(basename "$file")
    # Ignore these files and directories.
    if [[ " ${skip_files[@]} " =~ " ${filename} " ]]; then
        # Skip the files defined in the skip_files array.
        continue
    elif [ "$filename" = ".config" ]; then
        dst_config_dir="$dst_dir/.config"
        # Create .config.
        if [ ! -d "$dst_config_dir" ]; then
            mkdir "$dst_config_dir"
        fi
        # Copy .config files to HOME/.config.
        cp -r "$file/." "$dst_config_dir"
    else
        # Replace already existing dotfiles.
        cp "$file" "$dst_dir/$filename"
    fi
done

# Lazy
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

# vim-code-dark (neovim)
mkdir -p ~/.local/share/nvim/site/pack/themes/start
cd ~/.local/share/nvim/site/pack/themes/start
git clone https://github.com/tomasiser/vim-code-dark

