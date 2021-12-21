#!/usr/bin/env bash

name='Valtteri\n'
time="10#$(date +'%H')"

# night
if [[ ${time} -ge 0 && ${time} -lt 6 ]]; then
	timeOfDay='Hyvää yötä, '
fi

# morning
if [[ ${time} -ge 6 && ${time} -lt 12 ]]; then
	timeOfDay='Hyvää huomenta, '
fi

# day
if [[ ${time} -ge 12 && ${time} -lt 18 ]]; then
	timeOfDay='Hyvää päivää, '
fi

# evening
if [[ ${time} -ge 18 && ${time} -lt 24 ]]; then
	timeOfDay='Hyvää iltaa, '
fi

echo -e ${timeOfDay}${name} > /etc/issue

