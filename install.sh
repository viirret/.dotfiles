#!/bin/bash

# get .dotfiles and HOME directories
src_dir=$(pwd)
dst_dir=~

# copy all the files from src to dst
for file in "$src_dir"/*; do
	filename=$(basename "$file")
	if [ "$filename" = ".config" ]; then
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

