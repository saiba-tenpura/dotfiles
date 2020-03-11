# Don't do anything, if not running interactively.
[[ $- != *i* ]] && return

# Aliases
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vim='nvim'

# Defaults
export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="firefox"

# History
export HISTCONTROL=ignoreboth
export LESSHISTFILE=/dev/null

# Window
shopt -s checkwinsize
