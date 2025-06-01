#!/bin/sh

# WEATHER PLUGIN FOR SKETCHYBAR
#
# - Fetches: ⛅️ +69°F0.0mm
# - Strips the '+' from temperature
# - Only shows precipitation when it’s non‐zero
# - Updates $NAME (the SketchyBar item) with icon=<emoji> and label="<temp> [<precip>]" 
#

# 1) Fetch raw data
RAW="$(curl -s 'wttr.in/denver_co?format=%25c%25f%25p\n')"
# RAW="$(curl -s 'wttr.in/pheonix_az?format=%25c%25f%25p\n')"
# e.g. RAW="☀️  +62°F0.0mm"  (notice two spaces after emoji)

# 2) Collapse multiple spaces → single, and trim leading/trailing
#    (this yields: "☀️ +62°F0.0mm")
CLEAN="$(echo "$RAW" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+/ /g; s/[[:space:]]+$//')"

# 3) Split CLEAN on the first space
ICON="${CLEAN%% *}"            # “☀️”
REMAINDER="${CLEAN#* }"       # “+62°F0.0mm”

# Convert emoji icon into 
if [[ $ICON == "☀️" ]]; then # sunny
  ICON=""
elif [[ $ICON == "☁️" ]]; then # cloudy
  ICON="󰅣"
elif [[ $ICON == "⛅️" ]]; then # sunny with cloud
  ICON=""
elif [[ $ICON == "🌦️" ]]; then # sunny but raining
  ICON=""
elif [[ $ICON == "🌧" ]]; then
  ICON="" 
elif [[ $ICON == "🌩" ]]; then # thunder no rain
  ICON="󰖓"
elif [[ $ICON == "🌨" ]]; then 
  ICON=""
elif [[ $ICON == "⛈" ]]; then # rain and lightning
  ICON=""
elif [[ $ICON == "❄️" ]]; then # snowflake
  ICON=""
elif [[ $ICON == "🌨" ]]; then # cloud with snow
  ICON="󰖘"
elif [[ $ICON == "🌫" ]]; then # fog
  ICON=""
elif [[ $ICON == "✨" ]]; then # stars?
  ICON=""
fi

# 4) Extract temperature with sign (e.g. “+62°F”)
TEMP_WITH_SIGN="$(echo "$REMAINDER" | sed -E 's/^([+-]?[0-9]+°[FC]).*/\1/')"
TEMP="${TEMP_WITH_SIGN#+}"    # strips leading “+”, becomes “62°F”

# 5) Extract precipitation (e.g. “0.0mm” or “1.5mm”)
PRECIP="$(echo "$REMAINDER" | sed -E 's/.*?([0-9]+(\.[0-9]+)?mm)$/\1/')"
PRECIP_VALUE="${PRECIP%mm}"   # “0.0” or “1.5”

# 6) Decide whether to show precip
if [ "$(echo "$PRECIP_VALUE == 0" | bc 2>/dev/null)" -eq 1 ] 2>/dev/null; then
  LABEL="$TEMP"
else
  LABEL="$TEMP $PRECIP"
fi

# 7) Update SketchyBar
sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
