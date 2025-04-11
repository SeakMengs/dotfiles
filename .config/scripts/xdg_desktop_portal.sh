#!/usr/bin/env bash
sleep 4
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gtk
killall xdg-desktop-portal
sleep 4
systemctl --user start xdg-desktop-portal.service &
systemctl --user start xdg-desktop-portal-gtk.service &
systemctl --user start xdg-desktop-portal-hyprland.service &
