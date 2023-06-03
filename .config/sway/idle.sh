#!/usr/bin/env bash 

swayidle -w \
    timeout 300 '~/.config/sway/lock.sh --grace 5 --fade-in 10' \
    timeout 360 'hyprctl dispatch dpms off' \
        resume 'hyprctl dispatch dpms on' \
    before-sleep "~/.config/sway/lock.sh --fade-in 0"

