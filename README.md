# Dotfiles
This repository contains my personal configuration files for my linux setups (aka. **dotfiles**).

## Xorg
* **WM:** [i3](https://github.com/i3/i3)
* **Bar:** [Polybar](https://github.com/polybar/polybar) [Docky](https://github.com/adi1090x/polybar-themes/tree/master#docky) theme by adi1090x
* **Compositor:** [picom](https://github.com/yshui/picom)
* **Color Temperature Tool:** [Redshift](https://github.com/jonls/redshift)
* **Editor:** [Neovim](https://github.com/neovim/neovim) using my custom [pywal theme](https://github.com/saiba-tenpura/pywal_theme.nvim)
* **File Browser:** [nnn](https://github.com/jarun/nnn)
* **Terminal:** urxvt
* **Launcher/DMenu:** [rofi](https://github.com/davatorium/rofi) using the [Docky](https://github.com/adi1090x/polybar-themes/tree/master#docky) theme by adi1090x
* **Lockscreen:** [Betterlockscreen](https://github.com/betterlockscreen/betterlockscreen)
* **Notifications:** [Dunst](https://github.com/dunst-project/dunst)
* **PDF Viewer:** [zathura](https://github.com/pwmt/zathura)
* **Font:** Iosevka Term Nerd Font

## Wayland
* **WM:** [Hyprland](https://github.com/hyprwm/Hyprland)
* **Bar:** [Waybar](https://github.com/Alexays/Waybar)
* **File Browser:** [nnn](https://github.com/jarun/nnn)
* **Terminal:** [Kitty](https://github.com/kovidgoyal/kitty)
* **Editor:** [Neovim](https://github.com/neovim/neovim) using my custom [pywal theme](https://github.com/saiba-tenpura/pywal_theme.nvim)
* **Launcher/DMenu:** [Wofi](https://sr.ht/~scoopta/wofi/)
* **Lockscreen:** [swaylock-effects](https://github.com/mortie/swaylock-effects)
* **Notifications:** [Dunst](https://github.com/dunst-project/dunst)
* **PDF Viewer:** [zathura](https://github.com/pwmt/zathura)
* **Font:** IosevkaTerm Nerd Font

## Installation
*Disclaimer:* The install.sh script will backup any previously present dotfiles which would be overwritten to the .dotfiles.bak directory. In any case you should always have a backup of your files or try it with a freshly created user first. Just to be save in case something goes wrong.

The dotfiles are managed via a bare git repository.
```bash
# Download install script from this repository
curl -sO "https://raw.githubusercontent.com/saiba-tenpura/dotfiles/master/install.sh"

# Make the script executable
chmod 744 install.sh

# Run the script
./install.sh
```
