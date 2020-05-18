 
#!/bin/sh

# Displays todays precipication chance (☔) and daily low (🥶) and high (🌞).
# Usually intended for the statusbar.

# If we have internet, get a weather report from wttr.in and store it locally.
# You could set up a shell alias to view the full file in a pager in the
# terminal if desired. This function will only be run once a day when needed.
getforecast() { curl -sf "wttr.in/brisbane" > "${XDG_DATA_HOME:-$HOME/.local/share}/weatherreport" || exit 1 ;}

# Some very particular and terse stream manipulation. We get the maximum
# precipication chance and the daily high and low from the downloaded file and
# display them with coresponding emojis.
showweather() { printf "%s" "$(sed '16q;d' "${XDG_DATA_HOME:-$HOME/.local/share}/weatherreport" |
	grep -wo "[0-9]*%" | sort -rn | sed "s/^/☔ /g;1q" | tr -d '\n')"
sed '13q;d' "${XDG_DATA_HOME:-$HOME/.local/share}/weatherreport" | grep -o "m\\([-+]\\)*[0-9]\\+" | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " ❄",$1 "°","☀",$2 "°"}' ;}

# The BLOCK_BUTTON bloat for clicking in i3.
case $BLOCK_BUTTON in
    1) setsid "urxvt" -e less -Sf "${XDG_DATA_HOME:-$HOME/.local/share}/weatherreport" & ;;
    2) getforecast && showweather ;;
    3) notify-send "☀ Weather module" "\- Left click for full forecast.
- Middle click to update forecast.
☔: Chance of rain/snow
❄: Daily low
☀: Daily high" ;;
esac

# The test if our forcecast is updated to the day. If it isn't download a new
# weather report from wttr.in with the above function.
[ "$(stat -c %y "${XDG_DATA_HOME:-$HOME/.local/share}/weatherreport" 2>/dev/null | cut -d' ' -f1)" = "$(date '+%Y-%m-%d')" ] ||
	getforecast

showweather
