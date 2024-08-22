#!/bin/bash

# Check if grim and slurp are installed
if ! command -v grim &>/dev/null || ! command -v slurp &>/dev/null; then
  echo "Error: grim or slurp is not installed."
  notify-send "Error" "grim or slurp is not installed."
  exit 1
fi

# Screenshot save path
SAVE_DIR="$HOME/Pictures/Screenshots"

# Check if the save path exists, if not, create it
if [ ! -d "$SAVE_DIR" ]; then
  mkdir -p "$SAVE_DIR"
fi

# Select a region and capture its geometry | Uncomment this if using grim
# region=$(slurp)
# if [ -z "$region" ]; then
#   echo "Screenshot canceled or failed."
#   notify-send "Screenshot" "Screenshot canceled or failed."
#   exit 1
# fi

# Take a screenshot of the selected region
# grim -g "$region" - | wl-copy

# Save the screenshot from clipboard
# wl-paste >"$SAVE_DIR/Screenshot-$(date +%F_%T).png"
# notify-send "Screenshot" "Screenshot of the region taken"

grimblast --freeze copysave area "$SAVE_DIR/Screenshot-$(date +%F_%T).png"

#  Check the exit status of grimblast to determine if the operation was successful
if [ $? -eq 0 ]; then
  notify-send "Screenshot Taken" "Screenshot saved to $SAVE_DIR"
fi
