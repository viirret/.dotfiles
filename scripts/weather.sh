#!/bin/bash

data=$(curl -sfm 5 "${WTTRURL:-wttr.in}/$1")

if [ $? -eq 0 ]; then
    echo "$data" | less -r -S
else
    notify-send 'Failed to get weather forecast!' \
                'Check your internet connection.'
    exit 1
fi
