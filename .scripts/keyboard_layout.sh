#!/bin/bash

FILE="$HOME/.config/i3status/keyboard_layout"

update_keyboard_layout() {
    while true; do
        layout=$(xkblayout-state print "%s")
        echo "$layout" > "$FILE"
        sleep 1
    done
}

update_keyboard_layout &
