#!/usr/bin/env bash

name="Valtteri!\n\n"
time="10#$(date +'%H')"
day="$(date +'%a')"

# night
if [[ ${time} -ge 0 && ${time} -lt 6 ]]; then
	timeOfDay='Good night '
fi

# morning
if [[ ${time} -ge 6 && ${time} -lt 12 ]]; then
	timeOfDay='Good morning '
fi

# day
if [[ ${time} -ge 12 && ${time} -lt 18 ]]; then
	timeOfDay='Good day '
fi

# evening
if [[ ${time} -ge 18 && ${time} -lt 24 ]]; then
	timeOfDay='Good evening '
fi

# weekday
case ${day} in
	Mon) myday="Monday" ;;
	Tue) myday="Tuesday" ;;
	Wed) myday="Wednesday" ;;
	Thu) myday="Thursday" ;;
	Fri) myday="Friday" ;;
	Sat) myday="Saturday" ;;
	Sun) myday="Sunday" ;;
	*)
esac

todayis="Today is "
nums=" $(date +'%d').$(date +'%m')\n"

echo -e "Choose WM: \n1: i3\n2: Xmonad\nDefault: i3"
read choice

if [[ $choice == "1" ]]; then
	wm="i3"

elif [[ $choice == "2" ]]; then
	wm="xmonad"

else
	wm="i3" # i3 is default
fi

echo $wm

# update /etc/issue
echo -e ${timeOfDay}${name}${todayis}${myday}${nums} > /etc/issue

