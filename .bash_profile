#
# ~/.bash_profile
#

# Load bash config
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    startx
fi
