#!/usr/bin/env bash
# This script for selecting wallpapers (SUPER W)

# Wallpapers Path
wallpaperDir="$HOME/.config/hypr/wallpapers"
rofiTheme="$HOME/.config/rofi/wallpapers/wallpaper_select.rasi"
scriptPath="$HOME/.config/scripts"

# Transition config
FPS=60
TYPE="any"
DURATION=3
BEZIER="0.4,0.2,0.4,1.0"
SWWW_PARAMS="--transition-fps ${FPS} --transition-type ${TYPE} --transition-duration ${DURATION} --transition-bezier ${BEZIER}"

# Check if swaybg is running
if pidof swaybg >/dev/null; then
  pkill swaybg
fi

# Retrieve image files as a list
PICS=($(find -L "${wallpaperDir}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | sort))

# Use date variable to increase randomness
randomNumber=$((($(date +%s) + RANDOM) + $$))
randomPicture="${PICS[$((randomNumber % ${#PICS[@]}))]}"
randomChoice="[${#PICS[@]}] Random"

# Rofi command
rofiCommand="rofi -show -dmenu -theme ${rofiTheme}"

# Execute command according the wallpaper manager
executeCommand() {

  if command -v swww &>/dev/null; then
    echo "Wallpaper set to: $1" . $SWWW_PARAMS
    swww img "$1" ${SWWW_PARAMS}
  elif command -v swaybg &>/dev/null; then
    swaybg -i "$1" &
  else
    echo "Neither swww nor swaybg are installed."
    exit 1
  fi

  ln -sf "$1" "$HOME/.current_wallpaper"

  # Sleep for swww to finish otherwise pywal will interrupt swww animation
  sleep ${DURATION}

  # update pywal, waybar, swaync
  if command -v wal &>/dev/null; then
    wal -i "$1" && "${scriptPath}/pywal_cava.sh"
  fi

  if command -v pywalfox &>/dev/null; then
    pywalfox update
  fi

  if command -v waybar &>/dev/null; then
    killall -q waybar
    waybar &
  fi

  if command -v swaync &>/dev/null; then
    killall -q swaync
    swaync &
  fi
}

# Show the images
menu() {

  printf "$randomChoice\n"

  for i in "${!PICS[@]}"; do

    # If not *.gif, display
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(basename "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${PICS[$i]}\n"
    else
      # Displaying .gif to indicate animated images
      printf "$(basename "${PICS[$i]}")\n"
    fi
  done
}

# If swww exists, start it
if command -v swww &>/dev/null; then
  swww query || swww init
fi

# Execution
main() {
  choice=$(menu | ${rofiCommand})

  # No choice case
  if [[ -z $choice ]]; then
    exit 0
  fi

  # Random choice case
  if [ "$choice" = "$randomChoice" ]; then
    executeCommand "${randomPicture}"
    return 0
  fi

  # Find the selected file
  for file in "${PICS[@]}"; do
    # Getting the file
    if [[ "$(basename "$file" | cut -d. -f1)" = "$choice" ]]; then
      selectedFile="$file"
      break
    fi
  done

  # Check the file and execute
  if [[ -n "$selectedFile" ]]; then
    executeCommand "${selectedFile}"
    return 0
  else
    echo "Image not found."
    exit 1
  fi

}

# Check if rofi is already running
if pidof rofi >/dev/null; then
  pkill rofi
  exit 0
fi

main
