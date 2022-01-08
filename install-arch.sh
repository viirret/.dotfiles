#!/usr/bin/env bash

echo -e "UPDATING PACKAGES\n\n"
sudo pacman -Suy --noconfirm

echo -e "CREATING LOG FILE\n\n"
touch log.txt
log_file=~/log.txt

install()
{
	sudo pacman -S $1 --noconfirm
	if type -p $1 > /dev/null; then
		echo "$1 installed!" >> $log_file
	else
		echo "$1 failed to install" >> $log_file
	fi
}

echo -e "\nINSTALLING NEW PACKAGES\n"

install xorg
install vim
install picom
install cloc
install nitrogen
install cmatrix
install entr
install flameshot
install curl
install discord
install firefox
install i3
install polybar
install wget
install alacritty
install xmonad
install neofetch

# vundle, working but not ready
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# git clone https://aur.archlinux.org/octofetch.git

echo -e "\nSETTING SERVICES\n"
chmod +x update_issue.sh
mv $HOME/.services/update-issue.service /etc/systemd/system
systemctl daemon-reload
systemctl enable update-issue.service

