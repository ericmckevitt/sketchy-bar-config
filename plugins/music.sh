#!/usr/bin/env bash

# Ensure SketchyBar can find your binaries
export PATH="/Users/ericmckevitt/.cargo/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

NAME="spotify"

# 1) Check Spotify.app first
if osascript -e 'application "Spotify" is running' &>/dev/null; then
  STATE=$(osascript -e 'tell application "Spotify" to player state' 2>/dev/null)
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)
    if [ -n "$TRACK" ] && [ -n "$ARTIST" ]; then
      NEW_LABEL="$TRACK — $ARTIST"
      sketchybar --set "$NAME" drawing=on label="$NEW_LABEL"
      exit 0
    fi
  fi
fi

# 2) Fallback: rmpc + jq
if command -v rmpc >/dev/null && command -v jq >/dev/null; then
  RAW_STATE=$(rmpc status | jq -r '.state' 2>/dev/null)
  STATE="$(echo "$RAW_STATE" | tr '[:upper:]' '[:lower:]')"  # normalize
  if [ "$STATE" = "play" ]; then
    TITLE=$(rmpc song | jq -r '.metadata.title' 2>/dev/null)
    ARTIST=$(rmpc song | jq -r '.metadata.artist' 2>/dev/null)
    if [ -n "$TITLE" ] && [ -n "$ARTIST" ]; then
      NEW_LABEL="$TITLE — $ARTIST"
      sketchybar --set "$NAME" drawing=on label="$NEW_LABEL"
      exit 0
    fi
  fi
fi

# 3) If we reach here, nothing is playing. Always hide + clear label
sketchybar --set "$NAME" drawing=off label=""

exit 0
