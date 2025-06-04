#!/bin/sh

# WEATHER PLUGIN FOR SKETCHYBAR (Open-Meteo version)
#
# - Fetches current temp (°F), weather condition, and precipitation for Denver
# - You customize the icon per WMO code
# - Only shows precipitation in the label if it’s non-zero
# - Updates SketchyBar via $NAME with icon and label

LAT="39.7392"
LON="-104.9903"
URL="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code,precipitation&timezone=auto&temperature_unit=fahrenheit"

DATA=$(curl -s "$URL")

TEMP=$(echo "$DATA" | jq -r '.current.temperature_2m')             # e.g. 67.3 (Fahrenheit)
CODE=$(echo "$DATA" | jq -r '.current.weather_code')               # e.g. 2
PRECIP=$(echo "$DATA" | jq -r '.current.precipitation')           # e.g. 0.0

# Map WMO code to icon (you choose the icons)
case $CODE in
  0) ICON="" ;;      # Clear sky
  1) ICON="" ;;      # Mainly clear
  2) ICON="" ;;      # Partly cloudy
  3) ICON="" ;;      # Overcast
  45|48) ICON="" ;;  # Fog or depositing rime fog
  51|53|55) ICON="" ;;  # Drizzle: Light, moderate, dense
  56|57) ICON="?" ;;      # Freezing drizzle
  61|63|65) ICON="" ;;  # Rain: slight, moderate, heavy
  66|67) ICON="?" ;;      # Freezing rain
  71|73|75) ICON="󰖘" ;;  # Snowfall
  77) ICON="?" ;;         # Snow grains
  80|81|82) ICON="" ;;  # Rain showers
  85|86) ICON="?" ;;      # Snow showers
  95) ICON="󰖓" ;;        # Thunderstorm
  96|99) ICON="?" ;;      # Thunderstorm with hail
  *) ICON="" ;;         # Unknown
esac

# Format temp: round to nearest integer, add degree symbol
TEMP_LABEL="$(printf "%.0f°F" "$TEMP")"

# Only show precipitation if non-zero
if [ "$(echo "$PRECIP > 0" | bc -l)" -eq 1 ]; then
  LABEL="$TEMP_LABEL, $PRECIP mm"
  COLOR="0xFF89b4fa"
  sketchybar --set "$NAME" icon="$ICON" label="$LABEL" icon.color=$COLOR label.color=$COLOR
else
  LABEL="$TEMP_LABEL"
  sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
fi
