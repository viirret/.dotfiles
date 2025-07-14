# Remove fish greeting
set fish_greeting

if test -f ~/.scripts/shell_aliases.sh
    source ~/.scripts/shell_aliases.sh
end

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

