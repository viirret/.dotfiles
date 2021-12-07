# .BASHRC

[[ $- != *i* ]] && return

export PS1=' \[\e[0;35m\]\u\e[0;36m-> \e[0;32m\w\e[0;37m ' 

#
#	aliases
#
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' >> $HOME/.bashrc
alias ls='ls --color=auto'
alias la='ls -A'
alias ..='cd ..'
alias grep='grep --color=auto'
alias sammu='shutdown now -h now'
alias bye='shutdown now -h now'
alias c='clear'
alias free='sudo pacman -R $(pacman -Qdtq)'
alias vi='nvim'

# set vi keys to terminal
set -o vi

texrefresh()
{
	echo $1 | entr sh -c "pdflatex $1"
}


