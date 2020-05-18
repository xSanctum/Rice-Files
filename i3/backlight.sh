STEP_SIZE=${STEP_SIZE:-5}
USE_SUDO=${USE_SUDO:-0}

# whether to use `sudo` for changing the brightness (requires a NOPASSWD rule)
if [[ "$USE_SUDO" == "0" ]] ; then
    XBACKLIGHT_SET="xbacklight"
else
    XBACKLIGHT_SET="sudo xbacklight"
fi

case $BLOCK_BUTTON in
  3) xset dpms force off ;; # right click
  4) $XBACKLIGHT_SET -inc "$STEP_SIZE" ;; # scroll up
  5) $XBACKLIGHT_SET -dec "$STEP_SIZE" ;; # scroll down, decrease
esac


BRIGHTNESS=$(xbacklight -get | cut -c 1-2)
echo " ${BRIGHTNESS}% "
