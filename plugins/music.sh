#!/usr/bin/env bash

# Ensure SketchyBar can find your binaries
export PATH="/Users/ericmckevitt/.cargo/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

NAME="spotify"

# 1) Spotify
if osascript -e 'application "Spotify" is running' &>/dev/null; then
  STATE=$(osascript -e 'tell application "Spotify" to player state')
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track')
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
    sketchybar --set $NAME label="$TRACK — $ARTIST" drawing=on
    exit 0
  fi
fi

# 2) rmpc fallback using jq
if command -v rmpc >/dev/null && command -v jq >/dev/null; then
  STATE=$(rmpc status | jq -r '.state')
  if [ "$STATE" = "Play" ]; then
    TITLE=$(rmpc song | jq -r '.metadata.title')
    ARTIST=$(rmpc song | jq -r '.metadata.artist')
    sketchybar --set $NAME label="$TITLE — $ARTIST" drawing=on
    exit 0
  fi
fi

# 3) Nothing playing
# sketchybar --set $NAME drawing=off
sketchybar --set $NAME label=" $TITLE — $ARTIST" drawing=on
