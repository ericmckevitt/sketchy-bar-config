  #!/bin/bash
  if osascript -e 'application "Spotify" is running'; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track')
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
    sketchybar --set $NAME label="$TRACK - $ARTIST"
  else
    sketchybar --set $NAME label="Spotify is not running"
  fi

