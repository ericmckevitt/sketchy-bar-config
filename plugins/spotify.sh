  #!/bin/bash
  #
  # if osascript -e 'application "Spotify" is running'; then
  #   TRACK=$(osascript -e 'tell application "Spotify" to name of current track')
  #   ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
  #   sketchybar --set $NAME label="$TRACK - $ARTIST"
  # else
  #   sketchybar --set $NAME label="Spotify is not running"
  # fi


# if osascript -e 'application "Spotify" is running'; then
#   TRACK=$(osascript -e 'tell application "Spotify" to name of current track')
#   ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
#   STATE=$(osascript -e 'tell application "Spotify" to player state')
#
#   if [ "$STATE" = "playing" ]; then
#     sketchybar --set spotify label="$TRACK - $ARTIST" drawing=on
#   else
#     sketchybar --set spotify drawing=off
#   fi
# else
#   sketchybar --set spotify drawing=off
# fi
#

#!/bin/bash

if osascript -e 'application "Spotify" is running'; then
  TRACK=$(osascript -e 'tell application "Spotify" to name of current track')
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
  STATE=$(osascript -e 'tell application "Spotify" to player state')

  if [ "$STATE" = "playing" ]; then
    sketchybar --set spotify label="$TRACK - $ARTIST" drawing=on
  else
    sketchybar --set spotify drawing=off
  fi
else
  sketchybar --set spotify drawing=off
fi

