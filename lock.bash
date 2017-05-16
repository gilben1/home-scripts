#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

# Grabs a random icon from the folder ~/.lock_icons
icon=$(ls ~/.lock_icons | shuf -n 1)
# Adds the path to it
icon="$HOME/.lock_icons/$icon"

[[ -f $icon ]] && convert /tmp/screen.png $icon -gravity center -composite /tmp/screen.png

i3lock -i /tmp/screen.png
rm /tmp/screen.png
