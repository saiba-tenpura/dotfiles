#!/usr/bin/env bash

# Gen pywal & update polybar
~/.config/polybar/docky/scripts/pywal.sh $1

# Run post script
~/.config/wal/done.sh

