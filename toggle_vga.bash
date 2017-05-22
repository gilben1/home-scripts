#!/bin/bash

# Script by Nick Gilbert (nickgilbert2@gmail.com)
# Use and modify as you will

# Toggles the vga output to the left of the laptop screen

# If vga not found
if ! xrandr --listactivemonitors | grep "VGA1" ; then
    # Set it up to the left
    xrandr --output VGA1 --auto --left-of LVDS1
else
    # if found, turn it off
    xrandr --output VGA1 --off --output LVDS1 --auto
fi
