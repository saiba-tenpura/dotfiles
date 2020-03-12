#!/usr/bin/env bash

DOTFILES="${1:-https://github.com/aynsoph/dotfiles.git}"

dots() {
    /usr/bin/env git --git-dir=$HOME/.dotfiles --work-tree $HOME $@
}

git clone --bare "${DOTFILES}" $HOME/.dotfiles
dots checkout 2>&1
if [ $0 != 0 ]; then
    mkdir -p "$HOME/.dotfiles.bak"
    dots checkout 2>&1 \
        | grep -P '^\s+[\w.]' \
        | awk {'print $1'} \
        | xargs -I{} sh -c 'cp -r --parents "{}" "$HOME/.dotfiles.bak/" && rm -rf "{}"'
    dots checkout
fi
dots config --local status.showUntrackedFiles no
