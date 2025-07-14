#!/bin/bash
FILE="$HOME/.config/i3status/keyboard_layout"

update_keyboard_layout() {
    while true; do
        swaymsg -t get_inputs | grep "xkb_active_layout_name" | head -n 1 | awk -F '"' '{print $4}' > "$FILE"
        sleep 1
    done
}

update_keyboard_layout &

