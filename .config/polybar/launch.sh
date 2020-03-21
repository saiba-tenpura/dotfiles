#!/usr/bin/env bash

# Terminate already running instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch Polybar
printf -- "---\n" | tee -a /tmp/polybar.log
polybar -r ${1} >>/tmp/polybar.log 2>&1 &

printf "Polybar launched...\n"
