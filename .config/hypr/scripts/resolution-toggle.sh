#!/usr/bin/env bash

STATE="$XDG_RUNTIME_DIR/resolution-toggle"

if [[ -f "$STATE" ]]; then
    # Restore normal monitor configuration
    hyprctl reload

    rm "$STATE"
else
    # Switch all monitors to 1920x1080
    hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "0x0", scale = 1 })'
    hyprctl eval 'hl.monitor({ output = "DP-1", mode = "1920x1080@120", position = "auto", scale = 1, vrr = 1 })'
    hyprctl eval 'hl.monitor({ output = "DP-2", mode = "1920x1080@144", position = "auto", scale = 1, vrr = 1 })'

    touch "$STATE"
fi
