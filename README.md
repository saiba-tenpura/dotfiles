# Dotfiles
This repository contains my personal configuration files for my linux setups (aka. **dotfiles**).

## Xorg
![Xorg-Empty](https://user-images.githubusercontent.com/61359816/258656527-e960228f-fbe2-4e84-bd18-ced27db51669.png)
![Xorg-Busy](https://user-images.githubusercontent.com/61359816/258656540-529d3f23-26d1-46c1-8981-a25b73ececfc.png)

* **WM:** [i3](https://github.com/i3/i3)
* **Bar:** [Polybar](https://github.com/polybar/polybar) [Docky](https://github.com/adi1090x/polybar-themes/tree/master#docky) theme by adi1090x
* **Compositor:** [picom](https://github.com/yshui/picom)
* **Color Temperature Tool:** [Redshift](https://github.com/jonls/redshift)
* **Editor:** [Neovim](https://github.com/neovim/neovim) using my custom [pywal theme](https://github.com/saiba-tenpura/pywal_theme.nvim)
* **File Browser:** [Yazi](https://github.com/sxyazi/yazi)
* **Terminal:** [Ghostty](https://github.com/ghostty-org/ghostty)
* **Launcher/DMenu:** [rofi](https://github.com/davatorium/rofi) using the [Docky](https://github.com/adi1090x/polybar-themes/tree/master#docky) theme by adi1090x
* **Lockscreen:** [Betterlockscreen](https://github.com/betterlockscreen/betterlockscreen)
* **Notifications:** [Dunst](https://github.com/dunst-project/dunst)
* **PDF Viewer:** [zathura](https://github.com/pwmt/zathura)
* **Font:** NotoSansMono

## Wayland
![Wayland-Empty](https://github.com/saiba-tenpura/dotfiles/assets/61359816/e60b1849-780a-444b-b58a-830397ec9e17)
![Wayland-Busy](https://github.com/saiba-tenpura/dotfiles/assets/61359816/8635a55f-8718-40c5-9ff8-c6a5f5238c42)

* **WM:** [Hyprland](https://github.com/hyprwm/Hyprland)
* **Bar:** [Waybar](https://github.com/Alexays/Waybar)
* **File Browser:** [Yazi](https://github.com/sxyazi/yazi)
* **Terminal:** [Ghostty](https://github.com/ghostty-org/ghostty)
* **Editor:** [Neovim](https://github.com/neovim/neovim) using my custom [pywal theme](https://github.com/saiba-tenpura/pywal_theme.nvim)
* **Launcher/DMenu:** [Wofi](https://sr.ht/~scoopta/wofi/)
* **Lockscreen:** [swaylock-effects](https://github.com/mortie/swaylock-effects)
* **Notifications:** [Dunst](https://github.com/dunst-project/dunst)
* **PDF Viewer:** [zathura](https://github.com/pwmt/zathura)
* **Font:** NotoSansMono

## Installation
*Disclaimer:* The install.sh script will backup any previously present dotfiles which would be overwritten to the .dotfiles.bak directory. In any case you should always have a backup of your files or try it with a freshly created user first. Just to be save in case something goes wrong.

The dotfiles are managed via a bare git repository.
```bash
# Download install script from this repository
curl -sO "https://raw.githubusercontent.com/saiba-tenpura/dotfiles/master/install.sh"

# Run the script
./install.sh
```

## Author
This project was created in 2024 by Saiba Tenpura.
