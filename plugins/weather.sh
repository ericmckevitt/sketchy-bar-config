#!/bin/sh

# WEATHER PLUGIN FOR SKETCHYBAR
#
# - Fetches: ⛅️ +69°F0.0mm
# - Strips the '+' from temperature
# - Only shows precipitation when it’s non‐zero
# - Updates $NAME (the SketchyBar item) with icon=<emoji> and label="<temp> [<precip>]" 
#

RAW="$(curl -s 'wttr.in/Denver?format=%25c%25f%25p\n')"
# e.g. RAW="⛅️ +69°F0.0mm"

ICON="${RAW%% *}"
REMAINDER="${RAW#* }"                   # "+69°F0.0mm"

# Capture “+69°F” (or “-02°C”)
TEMP_WITH_SIGN="$(echo "$REMAINDER" | sed -E 's/^([+-]?[0-9]+°[FC]).*/\1/')"

# Strip leading “+”
TEMP="${TEMP_WITH_SIGN#+}"

PRECIP="$(echo "$REMAINDER" | sed -E 's/.*?([0-9]+(\.[0-9]+)?mm)$/\1/')"
PRECIP_VALUE="${PRECIP%mm}"              # remove “mm” → "0.0"

if [ "$(echo "$PRECIP_VALUE == 0" | bc)" -eq 1 ]; then
  LABEL="$TEMP"
else
  LABEL="$TEMP $PRECIP"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
