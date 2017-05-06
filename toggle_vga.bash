#!/bin/bash
if ! xrandr --listactivemonitors | grep "VGA1" ; then
    xrandr --output VGA1 --auto --left-of LVDS1  
else
    xrandr --output VGA1 --off --output LVDS1 --auto
fi
