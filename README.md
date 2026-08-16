# Dotfiles
This repository contains my personal configuration files for my linux setups (aka. **dotfiles**).

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
