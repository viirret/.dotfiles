#!/usr/bin/env bash

name="Valtteri\n\n"
time="10#$(date +'%H')"
day="$(date +'%a')"

# night
if [[ ${time} -ge 0 && ${time} -lt 6 ]]; then
	timeOfDay='Hyvää yötä '
fi

# morning
if [[ ${time} -ge 6 && ${time} -lt 12 ]]; then
	timeOfDay='Hyvää huomenta '
fi

# day
if [[ ${time} -ge 12 && ${time} -lt 18 ]]; then
	timeOfDay='Hyvää päivää '
fi

# evening
if [[ ${time} -ge 18 && ${time} -lt 24 ]]; then
	timeOfDay='Hyvää iltaa '
fi

# weekday
case ${day} in
	Mon) myday="maanantai" ;;
	Tue) myday="tiistai" ;;
	Wed) myday="keskiviikko" ;;
	Thu) myday="torstai" ;;
	Fri) myday="perjantai" ;;
	Sat) myday="lauantai" ;;
	Sun) myday="sunnuntai" ;;
	*)
esac

todayis="Tänään on "
nums=" $(date +'%d').$(date +'%m')\n"

echo -e ${timeOfDay}${name}${todayis}${myday}${nums} > /etc/issue

