#!/usr/bin/env bash

# Source pywal colors
. "$HOME/.cache/wal/colors.sh"

swaylock \
    --clock \
    --daemonize \
    --effect-blur 5x5 \
    --image "$HOME/wallpapers/current.png" \
    --indicator \
    --indicator-radius 75 \
    --indicator-thickness 5 \
    --inside-color 00000000 \
    --inside-clear-color 00000000 \
    --inside-ver-color 00000000 \
    --inside-wrong-color 00000000 \
    --key-hl-color "$color1" \
    --bs-hl-color "$color2" \
    --line-color 00000000 \
    --line-clear-color "$color2" \
    --line-ver-color ffffffff \
    --line-wrong-color "$color3" \
    --separator-color 00000000 \
    --text-color ffffffff \
    --text-clear-color ffffffff \
    --text-ver-color ffffffff \
    --text-wrong-color "$color3" \
    --ring-color ffffffff \
    --ring-clear-color "$color2" \
    --ring-ver-color ffffffff \
    --ring-wrong-color "$color3" \
    "$@"

