#
# ~/.bashrc
#

pwgen() {
    < /dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c${1:-32};
    echo;
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically run/load ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi

if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# Support for TTYs
. ~/.cache/wal/colors-tty.sh

# Aliase
alias diff='diff --color=auto'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls --color=auto'
alias vi='nvim'
alias vim='nvim'

# Defaults
export TERMINAL="ghostty"
export EDITOR="nvim"
export BROWSER="firefox"
export GTK_THEME="Adwaita:dark"
export GTK2_RC_FILES="/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc"

# History
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=131072
export HISTTIMEFORMAT='%F %T '
export LESSHISTFILE=/dev/null

# Window
shopt -s checkwinsize

# NNN
. ~/.config/nnn/nnn.sh

# Yazi
. ~/.config/yazi/yazi.sh

# Custom prompt
_YELLOW="\[$(tput setaf 3)\]"
_GREEN="\[$(tput setaf 2)\]"
_MAGENTA="\[$(tput setaf 5)\]"
_RESET="\[$(tput sgr0)\]"
PS1="\u${_YELLOW}@${_MAGENTA}\h${_RESET}: ${_GREEN}\W${_RESET} "

