# Dotfiles (WIP)

## Introduction
This repository contains my personal configuration files (aka. **dotfiles**) and the scripts I use to automatically setup on a new system.

## Overview
The dotfiles currently contain custom configurations for the following:
- **OS**: [Arch](https://archlinux.org)
- **Background Browser**: [Nitrogen](https://github.com/l3ib/nitrogen)
- **Bar**: [Polybar](https://github.com/polybar/polybar)
- **Compositor**: [picom](https://github.com/yshui/picom)
- **Editor**: [Neovim](https://github.com/neovim/neovim)
- **Hotkey Manager**: [sxhkd](https://github.com/baskerville/sxhkd)
- **Shell**: bash
- **Terminal**: [Alacritty](https://github.com/alacritty/alacritty)
- **Window Manager**: [bspwm](https://github.com/baskerville/bspwm)

## Installation
The project provides two ways for setup by either running the **install.sh** for just setting copying the configurations or the **script/install_hw.sh** which is targeted at setting up a complete machine from scratch from within the official [Arch Linux ISO](https://www.archlinux.org/download/).

### install.sh
Clones a given bare git repository to **~/.dotfiles** and installs the contained configuration files. Conflicting configuration files are backed up to **~/.dotfiles.bak**.

```bash
# Get the script & make it executable
curl -sO https://raw.githubusercontent.com/aynsoph/dotfiles/master/install.sh
chmod u+x install.sh

# Execute the script defaults to this repo
./install.sh

# Or using your own bare repo
./install.sh https://github.com/{user}/dotfiles.git
```

As for how to setup your own bare git repository for managing your dotfiles please take a look at [this](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

### scripts/deploy.sh
**! DISCLAIMER !**: Use at your own risk! Since this script as part of it's functionality wipes complete disks or heavily modifies the configuration files of a system you should either make sure you have backups or try it out in a VM first.

This script mainly serves for the purpose of quickly creating a new system from scratch.
The possible settings are defined & described at the top of the script itself.

#### Configuration
Can be used on an already existing machine to adjust the basic configuration. (or for example when the basic partioning scheme provided by the full installation of the script doesn't suffice)

```bash
# Get the script & make it executable
curl -sO https://raw.githubusercontent.com/aynsoph/dotfiles/master/scripts/deploy.sh
chmod u+x deploy.sh

# Execute
./deploy.sh --configure
```

The following configurations are made:
- **Time**:
  - The timezone will be set as defined by `$T_ZONE` for example 'Europe/Berlin'.
  - The **/etc/adjtime** is generated via `hwclock --systohc`.
  - Activates the time synchronisation via ntp.
- **Locale**:
  - Uncomments **en_US.UTF-8** in `/etc/locale.gen`.
  - Generates the locales & sets it in the `/etc/locale.conf`.
- **Keyboard Layout** (Only if country is 'DE'):
  - Creates the `/etc/vconsole.conf` & `/etc/X11/xorg.conf.d/20-keyboard.conf` to use a german keyboard layout.
- **Network**:
  - Sets hostname as defined by `$HOST`.
  - Create basic `/etc/hosts` file.
  - Enable the **dhcpd.service**.
- **User**:
  - Add user with name as defined by `$USER` and give him sudo privileges.
  - Configure & clone dotfiles for the newly created user.
- **Packaging**:
  - Install AUR Helper (yay) & download packages defined by `$AUR_LIST`.
- **Bootloader**
  - Install refind-efi or grub as bootloader as defined by `$BOOT_LDR`.

#### Full Installation
When performing a full installation the script should be executed in an Arch Linux ISO live environment. In addition to performing all the aforementioned configurations the script also setups the mirrorlist based on the given `$COUNTRY`, enables multilib support (to install 32-bit packages like steam), installs the basic packages and everything as defined by `$PKG_LIST` as well as a basic partition scheme. (MBR or GPT depending on the system)

```bash
# Get the script & make it executable
curl -sO https://raw.githubusercontent.com/aynsoph/dotfiles/master/scripts/deploy.sh
chmod u+x deploy.sh

# Execute
./deploy.sh
```

##### BIOS with MBR
| Mount Point |Partition  | Type | Size |
| :---------: |:--------: | :--: | :--: |
| /           | /dev/sdX1 | ext4 | 100% |

##### UEFI with GPT
| Mount Point |Partition  | Type  | Size          |
| :---------: |:--------: | :---: | :-----------: |
| /boot       | /dev/sdX1 | fat32 | 512MB         |
| /           | /dev/sdX1 | ext4  | 512MB - 100%  |

## Licenses
This files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.
