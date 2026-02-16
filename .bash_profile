#
# ~/.bash_profile
#

# Load bash config
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart
if systemctl -q is-active graphical.target && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    if [ "${XDG_SESSION_TYPE}" = "x11" ]; then
        exec startx
    elif [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
        exec start-hyprland
    fi
fi

