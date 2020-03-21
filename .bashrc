# Don't do anything, if not running interactively.
[[ $- != *i* ]] && return

# Aliases
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vim='nvim'
alias ytop='ytop -c ~/.config/ytop/main.json'

# Colors
red=$(tput setaf 1)
light_red=$(tput setaf 9)
reset=$(tput sgr0)

# Defaults
export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="firefox"

# History
export HISTCONTROL=ignoreboth
export LESSHISTFILE=/dev/null

# Prompt
PS1="[\u:\[$red\]\W\[$reset\[] \[$light_red\]\$\[$reset\] "

# Window
shopt -s checkwinsize
