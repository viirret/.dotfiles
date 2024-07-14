# Remove fish greeting
set fish_greeting

#
# aliases
#
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' >> $HOME/.bashrc
alias bye='shutdown now -h now'
alias c='clear'
alias vi='nvim'
alias myip='curl http://ipecho.net/plain; echo'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

export EDITOR=vim

# Set vi mode
function fish_user_key_bindings
    fish_vi_key_bindings
end

# mkdir + cd
function mkcd
    mkdir $argv && cd $argv
end

# Arch Linux debuginfod
set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

