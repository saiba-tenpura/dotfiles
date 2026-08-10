#!/usr/bin/env bash

STATE="$XDG_RUNTIME_DIR/waybar-hidden"
hidden_on_workspace="special:magic"

hide() {
    killall -SIGUSR1 waybar && touch "$STATE" 
}

show() {
    if [ -f "$STATE" ]; then
        killall -SIGUSR1 waybar && rm "$STATE" >> /dev/null 2>&1
    fi
}

sleep 1
current_workspace="$(hyprctl activewindow -j | jq -r '.workspace.name')"
[[ "$hidden_on_workspace" == "$current_workspace" ]] && hide

socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" STDOUT | while read -r event; do
    case $event in 
        activespecial\>\>$hidden_on_workspace*)
            hide
            ;;
        activespecial\>\>*)
            show
            ;;
    esac
done

show
