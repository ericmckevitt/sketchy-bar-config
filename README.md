# Sketchybar Configuration

![Demo Image](./img/sketchybar_demo.png)

This repository contains my personal [SketchyBar](https://github.com/FelixKratz/SketchyBar) configuration for macOS. I have set up my configuration to be a relatively minimal menu bar, where items/widgets disappear from view when not needed. The main configuration file is [`./sketchybarrc`](./sketchybarrc), which sets up the bar layout, appearance, and behavior.  

## 📂 File Overview

- `./sketchybarrc`: Main setup script defining bar structure and visuals.
- `$CONFIG_DIR/colors.sh`: Defines color variables used across the config.
- `$PLUGIN_DIR/*.sh`: Scripts powering individual modules (Music, clock, weather, etc).

## ⚙️ Features

- Left-aligned items:
  - Apple logo
  - Current frontmost app
  - Window title (from [Aerospace](https://github.com/nikitabobko/AeroSpace))
  - Music playback info (shown only when media is playing)
- Right-aligned items:
  - Clock
  - Weather (temperature and precipitation if forecasted)
  - Volume (hidden when volume is muted)
  - Battery (uses colors at low percentages to subtly draw attention)
  - Disk usage
  - CPU usage graph
