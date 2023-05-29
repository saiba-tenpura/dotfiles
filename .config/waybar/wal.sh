#!/usr/bin/env bash

# Symlink waybar style
ln -sf ~/.cache/wal/style-waybar.css ~/.config/waybar/style.css

# Restart waybar with the new styles
pkill waybar
waybar &

