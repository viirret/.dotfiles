# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

# remove fish greeting
set fish_greeting

# doom emacs 
export PATH="$HOME/.emacs.d/bin/:$PATH"

#
# aliases
#
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' >> $HOME/.bashrc
alias sammu='shutdown now -h now'
alias bye='shutdown now -h now'
alias c='clear'
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

# colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# set vi mode
function fish_user_key_bindings
	fish_vi_key_bindings
end

# neovim as manpager
set -x MANPAGER "nvim -c 'set ft=man' -"
