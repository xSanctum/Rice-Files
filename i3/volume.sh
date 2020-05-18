#!/bin/sh

# Prints the current volume or 🔇 if muted. Uses PulseAudio by default,
# uncomment the ALSA lines if you remove PulseAudio.

case $BLOCK_BUTTON in
	# 1) setsid "urxvt" -e alsamixer & ;;
	# 2) amixer sset Master toggle ;;
	# 4) amixer sset Master 5%+ >/dev/null 2>/dev/null ;;
	# 5) amixer sset Master 5%- >/dev/null 2>/dev/null ;;
	1) setsid "$TERMINAL" -e pulsemixer & ;;
	2) pamixer -t ;;
	4) pamixer --allow-boost -i 1 ;;
	5) pamixer --allow-boost -d 1 ;;
	3) notify-send "📢 Volume module" "\- Shows volume 🔊, 🔇 if muted.
- Middle click to mute.
- Scroll to change."
esac

volstat="$(pactl list sinks)"
# volstat="$(amixer get Master)" # ALSA only equivalent.

echo "$volstat" | grep -q "Mute: yes" && printf "🔇\\n" && exit
# echo "$volstat" | grep "\[off\]" >/dev/null && printf " 🔇\\n  " && exit # ALSA

vol="$(echo "$volstat" | grep '[0-9]\+%' | sed "s,.* \([0-9]\+\)%.*,\1,;1q")"
# vol=$(echo "$volstat" | grep -o "\[[0-9]\+%\]" | sed "s/[^0-9]*//g;1q") # ALSA

if [ "$vol" -gt "70" ]; then
	icon="🔊"
elif [ "$vol" -lt "30" ]; then
	icon="🔈"
else
	icon="🔉"
fi

printf " %s %s%% \\n " "$icon" "$vol"
