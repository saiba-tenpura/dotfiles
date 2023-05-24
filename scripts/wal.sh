#!/usr/bin/env bash

if [[ "$XDG_SESSION_TYPE" == 'wayland' ]]; then
    # Gen pywal
    wal -i "$1" -q -t
else
    # Gen pywal & update polybar
    ~/.config/polybar/docky/scripts/pywal.sh $1
fi

# Run post script
~/.config/wal/done.sh

