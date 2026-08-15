#!/usr/bin/env bash

# Symlink waybar style
ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/style.css

# Restart waybar with the new styles
pkill waybar
waybar &

