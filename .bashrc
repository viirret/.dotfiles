# .BASHRC

[[ $- != *i* ]] && return

export PS1=' \[\e[0;35m\]\u\e[0;36m-> \e[0;32m\w\e[0;37m '

#
#  Aliases
#
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' >> $HOME/.bashrc
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias la='ls -A'
alias ..='cd ..'
alias bye='shutdown now -h now'
alias c='clear'
alias vi='nvim'
alias myip="curl http://ipecho.net/plain; echo"

# Set vi keys to terminal.
set -o vi

# mkdir + cd
mkcd()
{
    mkdir $1
    cd $1
}

# history settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=1000

texrefresh()
{
    echo $1 | entr sh -c "pdflatex $1"
}

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

