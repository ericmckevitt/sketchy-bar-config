#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:

sketchybar --set "$NAME" label="$(date +'%a %b %d %-I:%M %p')" padding_left=0

