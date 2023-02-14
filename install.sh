#!/bin/bash

# get .dotfiles and HOME directories
src_dir=$(pwd)
dst_dir=~

# don't copy these files to HOME directory
skip_files=(".git" ".gitignore" "README.md" "install.sh")

# copy all the files from src to dst
for file in "$src_dir"/.[^.]*; do
	filename=$(basename "$file")
	# ignore these files and directories
	if [[ " ${skip_files[@]} " =~ " ${filename} " ]]; then
    	# skip the files defined in the skip_files array
    	continue
	elif [ "$filename" = ".config" ]; then
		dst_config_dir="$dst_dir/.config"
		# create .config
		if [ ! -d "$dst_config_dir" ]; then
			mkdir "$dst_config_dir"
		fi
		# copy .config files to HOME/.config
		cp -r "$file/." "$dst_config_dir"
	else
		# replace already existing dotfiles
		rm -f "$dst_dir/$filename"
		cp "$file" "$dst_dir/$filename"
	fi
done

# 	VIM

# pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# lightline.vim
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim

# vim-rainbow
git clone https://github.com/frazrepo/vim-rainbow ~/.vim/bundle/vim-rainbow

# vim-code-dark
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/tomasiser/vim-code-dark

# vim-code-dark (neovim)
mkdir -p ~/.local/share/nvim/site/pack/themes/start
cd ~/.local/share/nvim/site/pack/themes/start
git clone https://github.com/tomasiser/vim-code-dark

# YouCompleteMe
git clone https://github.com/ycm-core/YouCompleteMe ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
