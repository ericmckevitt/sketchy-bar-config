#!/usr/bin/env bash

NAME="spotify"

# 1) Immediately hide + clear label, in case nothing is playing.
sketchybar --set "$NAME" drawing=off label=""

# 2) If rmpc/jq exist, check state
if command -v rmpc >/dev/null && command -v jq >/dev/null; then
  STATE=$(rmpc status | jq -r '.state')   # usually "play", "pause", or "stop"

  if [ "$STATE" = "play" ]; then
    # 3) Grab title + artist
    TITLE=$(rmpc song | jq -r '.metadata.title')
    ARTIST=$(rmpc song | jq -r '.metadata.artist')

    # 4) Only if both TITLE and ARTIST are non‐empty, show the widget
    if [ -n "$TITLE" ] && [ -n "$ARTIST" ]; then
      sketchybar --set "$NAME" \
        drawing=on \
        icon="" \
        label="$TITLE — $ARTIST"
    fi
  fi
fi

# export PATH="/Users/ericmckevitt/.cargo/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"


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

# USING THIS PREVIOUSLY
#!/bin/bash
# NAME="spotify"
#
# # rmpc only
# if command -v rmpc >/dev/null && command -v jq >/dev/null; then
#   STATE=$(rmpc status | jq -r '.state')
#   if [ "$STATE" = "Play" ]; then
#     TITLE=$(rmpc song | jq -r '.metadata.title')
#     ARTIST=$(rmpc song | jq -r '.metadata.artist')
#     sketchybar --set $NAME label="$TITLE — $ARTIST" drawing=on
#     exit 0
#   fi
# fi
#
# # 3) Neither playing
# sketchybar --set $NAME drawing=off
