#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

icon=$HOME/Pictures/affinty.png
[[ -f $icon ]] && convert $icon -scale 50% /tmp/icon.png
icon=/tmp/icon.png

[[ -f $icon ]] && convert /tmp/screen.png $icon -gravity center -composite -matte /tmp/screen.png

i3lock -i /tmp/screen.png
rm /tmp/screen.png
