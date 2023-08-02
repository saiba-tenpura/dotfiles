#!/usr/bin/env bash

if [ -e ~/.config/dunst/wal.sh ]; then
    ~/.config/dunst/wal.sh
fi

if [ -e ~/.config/zathura/wal.sh ]; then
    ~/.config/zathura/wal.sh
fi

if [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
    if [ -e ~/.config/hypr/wal.sh ]; then
        ~/.config/hypr/wal.sh
    fi

    if [ -e ~/.config/waybar/wal.sh ]; then
        ~/.config/waybar/wal.sh
    fi

    if [ -e ~/.config/wlogout/wal.sh ]; then
        ~/.config/wlogout/wal.sh
    fi
fi
