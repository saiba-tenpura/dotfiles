#
# ~/.bashrc
#

pwgen() {
    < /dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c${1:-32};
    echo;
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# Support for TTYs
source ~/.cache/wal/colors-tty.sh

# Aliase
alias diff='diff --color=auto'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls --color=auto'
alias vi='nvim'
alias vim='nvim'

# Defaults
export TERMINAL="urxvt"
export EDITOR="nvim"
export BROWSER="firefox"

# History
export HISTCONTROL=ignoreboth
export HISTSIZE=8096
export LESSHISTFILE=/dev/null

# Window
shopt -s checkwinsize

# NNN
export NNN_OPTS="H"

# Custom prompt
_YELLOW="\[$(tput setaf 3)\]"
_GREEN="\[$(tput setaf 2)\]"
_MAGENTA="\[$(tput setaf 5)\]"
_RESET="\[$(tput sgr0)\]"
PS1="\u${_YELLOW}@${_MAGENTA}\h${_RESET}: ${_GREEN}\W${_RESET} "
