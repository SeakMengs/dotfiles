#!/usr/bin/env bash
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gtk
killall xdg-desktop-portal
# /usr/lib/xdg-desktop-portal-hyprland &
systemctl --user start xdg-desktop-portal-hyprland.service
sleep 2
systemctl --user start xdg-desktop-portal.service
# /usr/lib/xdg-desktop-portal &
