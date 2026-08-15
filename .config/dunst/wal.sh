#!/usr/bin/env bash

# Symlink dunst config
ln -sf ~/.cache/wal/colors-dunstrc ~/.config/dunst/dunstrc

# Restart dunst with the new color scheme
pkill dunst
dunst &

