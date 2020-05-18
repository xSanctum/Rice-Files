
#!/bin/sh

bg_color=#313539
text_color=#ffffff
htext_color=#cc00cc

rofi -show run -lines 3 -eh 2 -width 40 -padding 20 -opacity "85" -bw 0 -color-window "$bg_color, $bg_color, $bg_color" -color-normal "$bg_color, $text_color, $bg_color, $bg_color, $htext_color" -font "MesloLGS NF 13"
