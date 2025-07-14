#!/bin/bash

# Check if the device is a laptop
if [ ! -d "/sys/class/power_supply/BAT0" ]; then
    echo "This device is not a laptop. Exiting."
    exit 1
fi

check_battery() {
  battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
  if [ $battery_level -le 20 ]; then
    notify-send "Battery low" "Battery level at $battery_level%"
  fi
}

main() {
    while true; do
        check_battery
        sleep 60
    done
}

main &
