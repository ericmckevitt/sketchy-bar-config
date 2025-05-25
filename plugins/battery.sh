#!/bin/sh

source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="􀛨"
  ;;
  [6-8][0-9]) ICON="􀺸"
  ;;
  [3-5][0-9]) ICON="􀺶"
  ;;
  [1-2][0-9]) ICON="􀛩"
  ;;
  *) ICON="􀛪"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="􀢋"
fi

# red at ≤10%, orange at ≤20%, white otherwise
if [ "$PERCENTAGE" -le 10 ]; then
  COLOR="$RED"
elif [ "$PERCENTAGE" -le 20 ]; then
  COLOR="$ORANGE"
else
  COLOR="$WHITE"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
# sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" padding_right=0 
#
#
# if [ "$PERCENTAGE" -le 99 ]; then
#   sketchybar --set "$NAME" \
#     icon="$ICON" \
#     label="${PERCENTAGE}%" \
#     icon.color="$COLOR" \
#     label.color="$COLOR" \
#     padding_right=0
# else
#   sketchybar --set "$NAME" drawing=off
# fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  label="${PERCENTAGE}%" \
  icon.color="$COLOR" \
  label.color="$COLOR" \
  padding_right=0

# if [ "$PERCENTAGE" -lt 100 ]; then
#   sketchybar --set "$NAME" \
#     icon="$ICON" \
#     label="${PERCENTAGE}%" \
#     icon.color="$COLOR" \
#     label.color="$COLOR" \
#     padding_right=0
# else
#   sketchybar --set "$NAME" drawing=off
# fi
