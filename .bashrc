# .BASHRC

# if not running interactively don't do anything
[[ $- != *i* ]] && return

export PS1=' \[\e[0;35m\]\u\e[0;36m-> \e[0;32m\w\e[0;37m ' 

# history settings 
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=1000

#
# aliases
#
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' >> $HOME/.bashrc
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias la='ls -A'
alias ..='cd ..'
alias sammu='shutdown now -h now'
alias bye='shutdown now -h now'
alias c='clear'
alias free='sudo pacman -R $(pacman -Qdtq)'
alias vi='nvim'
alias myip='curl http://ipecho.net/plain; echo'
alias neo='neo --charset=ascii'
alias m='mount'
alias um='unmount'

# git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias fetch='git fetch'
alias pull='git pull'

# set vi keys to terminal
set -o vi

# cd + ls
cl()
{
	cd $1
	ls
}

# mkdir + cd
mkcd()
{
	mkdir $1
	cd $1
}

# refresh pdflatex automatically
texrefresh()
{
	echo $1 | entr sh -c "pdflatex $1"
}

