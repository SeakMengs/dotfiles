#!/bin/bash

# Check if grimblast is installed
if ! command -v grimblast &>/dev/null; then
  notify-send "Error" "grimblast is not installed."
  exit 1
fi

SAVE_DIR="$HOME/Pictures/Screenshots"

mkdir -p "$SAVE_DIR"

FILENAME="Screenshot-$(date +%F_%T).png"
SAVE_PATH="$SAVE_DIR/$FILENAME"

# Take a screenshot of a region (area) and save+copy it
grimblast --freeze copysave area "$SAVE_PATH"

if [ $? -eq 0 ]; then
  notify-send "Screenshot Taken" "Saved to $SAVE_PATH."
else
  notify-send "Screenshot Cancel" "Screenshot was cancelled or failed."
fi
