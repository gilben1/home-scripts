#!/bin/bash

# Script modified by Nick Gilbert
# Original script found here: https://pastebin.com/ZpYghBkQ
# Use and modify as you will

# Locks the screen with a pixellated screenshot of the screen right before lock
# Adds an optional icon grabbed randomly from the ~/.lock_icons directory
# Note, all icons look best at 160 x 160 on a 1366 x 768 screen
#   some experimentation may be required to make the icon look good

# Properly applies the image to each screen using xrandr


scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
# Grabs a random icon from the folder ~/.lock_icons
icon=$(ls ~/.lock_icons | shuf -n 1)

# Adds the path to it
icon="$HOME/.lock_icons/$icon"


if [[ -f $icon ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $icon | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)

    SR=$(xrandr --query | grep ' connected' | cut -f3 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))

        convert /tmp/screen.png $icon -geometry +$PX+$PY -composite -matte  /tmp/screen.png
        echo "done"
    done
fi
#i3lock -e -u -n -i /tmp/screen.png
i3lock -i /tmp/screen.png
