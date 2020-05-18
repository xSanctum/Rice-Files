#!/bin/bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9]?%')

#BAT=$(( $BAT1 + $BAT2 ))

STATE=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state" | tr -d "state:" | tr -d " ")

BAT1=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "percentage" | tr -d "percentage:" | tr -d " ")

BAT2=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "percentage" | tr -d "percentage:" | tr -d " ")

# Full and short texts

if [ $STATE == chrging ] || [ $STATE == charging] || [$STATE == fully-charged ] || [ $STATE == fully-chrged] 
then
    echo " ⚡ $BAT1 + $BAT2 "
else
    echo " ⏻ $BAT1 + $BAT2 "
fi
#echo " ⏻ $BAT1 + $BAT2 "

# Set urgent flag below 5% or use orange below 20%
#[ ${BAT%?} -le 5 ] && exit 33
#[ ${BAT%?} -le 20 ] && echo "#FF8000"

exit 0
