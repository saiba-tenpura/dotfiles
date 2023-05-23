#!/usr/bin/env bash 

swayidle -w \
    timeout 300 '~/.config/swaylock/lock.sh --grace 5 --fade-in 10' \
    timeout 360 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    before-sleep "~/.config/swaylock/lock.sh --fade-in 0" &

