# Dotfiles

## Introduction
This repository contains my personal configuration files (aka. **dotfiles**).

* **OS:** Arch Linux
* **WM:** i3
* **Bar:** polybar
* **Color Temperature Tool:** redshift
* **Compositor:** picom
* **Clipboard Manager:** xclip
* **Editor:** neovim
* **File Browser:** nnn
* **Launcher:** rofi
* **Lockscreen:** betterlockscreen
* **Notification daemon:** dunst
* **PDF Viewer:** zathura
* **Terminal:** urxvt

## Installation
*Disclaimer:* The install script will copy dotfiles which would overwritten to the .dotfiles.bak directory. In any case you should always have a backup or at least try it with a newly created user first. Just in case something goes wrong.

The dotfiles are managed via a bare git repository.
```bash
# Download install script from this repository
curl -sO "https://raw.githubusercontent.com/saiba-tenpura/dotfiles/master/install.sh"

# Make the script executable
chmod 744 install.sh

# Run the script
./install.sh
```
