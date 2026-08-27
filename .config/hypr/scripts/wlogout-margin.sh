#!/usr/bin/env bash

if hyprctl monitors | grep -qE "3840x2160"; then
    wlogout -b 4 -T 350 -B 350
else
    wlogout -b 4 -T 250 -B 250
fi
