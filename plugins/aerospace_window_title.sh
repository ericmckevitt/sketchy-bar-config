#!/bin/bash

title=$(aerospace list-workspaces --focused)

# Fallback if no window is focused
if [ -z "$title" ]; then
  title="No Window"
fi

sketchybar --set window_title label="$title"
