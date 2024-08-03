#!/bin/bash

echo $(grep -oP '(?<=\$wallpaper_path = ).*' $HOME/.config/hypr/hyprpaper.conf | sed "s|\$HOME|${HOME}|")

