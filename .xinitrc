#!/usr/bin/env bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Rebuild lockscreen cache if missing
[ ! -d $HOME/.cache/betterlockscreen/current ] && betterlockscreen -u $HOME/wallpapers/current

udiskie &
xset s 300 300
xset dpms 300 450 600
xrandr --dpi 192 --fb 7680x4120 \
    --output DisplayPort-0 --mode 3840x2160 --rate 143.99 \
    --output HDMI-A-0 --scale 2x2 --pos 3840x0 --panning 3840x2160+3840+0
exec i3
