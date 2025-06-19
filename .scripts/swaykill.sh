#!/bin/bash

WIN_SELECTION=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | "\(.pid) \(.name)"' | rofi -dmenu -p "Kill window")
PID=$(echo "$WIN_SELECTION" | awk '{print $1}')
if [ -n "$PID" ]; then
    kill -9 "$PID"
    notify-send "swaykill" "Killed PID $PID"
fi
