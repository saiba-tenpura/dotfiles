# Dotfiles

## Introduction
This repository contains my personal configuration files (aka. **dotfiles**).

* *OS:* Arch Linux
* *WM:* i3
* *Bar:* polybar
* *Compositor:* picom
* *Clipboard Manager:* xclip
* *Launcher:* rofi
* *Lockscreen:* betterlockscreen
* *Terminal:* urxvt
* *Editor:* Neovim
* *PDF Reader:* Zathura
* *File Browser:* nnn
* *Notification daemon:* dunst

## Installation
*Disclaimer:* The install script will copy dotfiles which would need to overwritten to the .dotfiles.bak directory. In any case you should always have a backup or at least try it with a newly created user first. Just in case something goes wrong.

Download the install script from this repository, make executeable and run it.
```bash
curl -sO "https://raw.githubusercontent.com/saiba-tenpura/dotfiles/master/install.sh"
chmod 744 install.sh
./install.sh
```

