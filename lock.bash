#!/bin/bash

# Locks the screen with a pixellated screenshot of the screen right before lock
# Adds an optional icon grabbed randomly from the ~/.lock_icons directory
# Note, all icons look best at 160 x 160 on a 1366 x 768 screen
#   some experimentation may be required to make the icon look good

# Screenshot the screen
scrot /tmp/screen.png
# Scale down and back up for pixellated effect
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

# Grabs a random icon from the folder ~/.lock_icons
icon=$(ls ~/.lock_icons | shuf -n 1)

# Adds the path to it
icon="$HOME/.lock_icons/$icon"

# If the icon exists, add it to pretty much the center
[[ -f $icon ]] && convert /tmp/screen.png $icon -gravity center -geometry -2-1 -composite /tmp/screen.png

# Run i3lock with our generated screenshot
i3lock -i /tmp/screen.png

# remove when done
rm /tmp/screen.png
