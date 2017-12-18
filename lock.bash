#!/bin/bash

# Script modified by Nick Gilbert (nickgilbert2@gmail.com)
# Original script found here: https://pastebin.com/ZpYghBkQ

# Added functionality with i3lock-color found here: https://github.com/pavanjadhaw/betterlockscreen

# Use and modify as you will

# Locks the screen with a pixellated screenshot of the screen right before lock
# Adds an optional icon grabbed randomly from the ~/.lock_icons directory
# Note, all icons look best at 160 x 160 on a 1366 x 768 screen
#   some experimentation may be required to make the icon look good

# Properly applies the image to each screen using xrandr

if `pgrep 'wal-timed$' > /dev/null` ; then
    pkill -STOP 'wal-timed$'
    wkill=1
fi


source "${HOME}/.cache/wal/colors.sh"


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

rectangles=" "
SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in $SR; do
    SRA=(${RES//[x+]/ })
    CX=$((${SRA[2]} + 25))
    CY=$((${SRA[1]} - 30))
    rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
done

convert /tmp/screen.png -draw "fill black fill-opacity 0.4 $rectangles" /tmp/screen.png

letterEnteredColor=${color4//#}ff
letterRemovedColor=${color5//#}ff
passwordCorrect=00000000
passwordIncorrect=d23c3dff
background=33333311
foreground=ffffffff
ringcolor=${color10//#}ff

perform_lock()
{
    i3lock \
        -n -i "/tmp/screen.png" \
        --timepos="x-90:h-ch+30" \
        --datepos="tx+24:ty+25" \
        --clock --datestr "Type password to unlock..." \
        --insidecolor=$background --ringcolor=$ringcolor --line-uses-inside \
        --keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
        --insidevercolor=$passwordCorrect --insidewrongcolor=$background \
        --ringvercolor=$ringcolor --ringwrongcolor=$passwordIncorrect --indpos="x+280:h-70" \
        --radius=20 --ring-width=4 --veriftext=":)" --wrongtext="):" \
        --textcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground"
    if ! [ -z "$wkill" ] ; then
        notify-send "Wal-timed was resumed"
        pkill -CONT 'wal-timed$'
    fi
}
perform_lock &
sleep 1

#i3lock -i /tmp/screen.png

#i3lock -k \
#    --ringcolor=${color10//#}ff \
#    --ringvercolor=${color10//#}ff \
#    --insidevercolor=${color4//#}ff \
#    --keyhlcolor=${color4//#}ff \
#    --timecolor=${color10//#}ff \
#    --timepos="w/2-cw/2:h/2+30" \
#    --datecolor=${color10//#}ff \
#    -i /tmp/screen.png
