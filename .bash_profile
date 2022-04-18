# .BASH_PROFILE

[[ -f ~/.bashrc ]] && . ~/.bashrc

export BROWSER="firefox"
export EDITOR="vim"
export USER="valtteri"

# tty startx default
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
