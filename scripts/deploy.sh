#!/usr/bin/env bash

# BLOCK_DEVICE    Target block device for installation.
# BOOT_LDR        Bootloader to use. Supported options are BIOS: grub UEFI: grub refind-efi
# COUNTRY         Country used for mirrorlist generation.
# DOTFILES        Repository containing user dotfiles.
# PKG_LIST        List of packages to add to base installation. (Included by Default: dhcpcd, git, sudo)
# HOST            Hostname to set for the new system.
# USER            Name of sudo user to create.
# T_ZONE          Timezone of the system. (i.e. '/usr/share/zoneinfo/${T_ZONE}')

BLOCK_DEVICE="/dev/sda"
BOOT_LDR="refind-efi"
COUNTRY="DE"
DOTFILES="https://github.com/aynsoph/dotfiles"
PKG_LIST="alacritty blender bspwm gimp neovim nitrogen picom pulseaudio pulseaudio-alsa sxhkd ttf-fantasque-sans-mono xorg-server xorg-xinit"
AUR_LIST="polybar"
HOST="alpha"
USER="aynsoph"
T_ZONE="Europe/Berlin"

# Print usage info && exit
usage() {
    cat <<-EOF
	Usage: $(basename "${0}") [options]

	Options:
	-b, --device <block_device>    Block device to install to.
	-c, --configure                Flag for only performing basic system configuration.
	-d, --dotfiles <repo_url>      Dotfiles repository to install.
	-h, --help                     Show this help message.
	-i, --country <country>        ISO 3166-1 alpha-2 country code. e.g. 'DE'.
	-l, --bootloader <boot_loader> Bootloader to use. Supported are either 'grub' or 'refind-efi'
	-n, --name <hostname>          Hostname to set for new system.
	-t, --timezone <timezone>      Timezone of the system. e.g. 'America/New_York'.
	-u, --user <username>          Name of the sudo user to create.

	Additional configuration options are contained and explained within the script itself.

	Full installation:
	For a full installation run this script without any parameters.

	Configuration:
	To only configure the system run it with '-c' or '--configure' flag.
	EOF

    exit 1
}

# Check Requirements
check_reqs() {
    # Usage: check_reqs device boot_ldr
    local p progs
    progs="arch-chroot cp curl genfstab grep lsblk mkfs.ext4 mkfs.vfat mount pacman pacstrap parted umount"

    [ $(id -u) = 0 ] || _error "Script must be run as root!"
    [ -b "${BLOCK_DEVICE}" ] || _error "${BLOCK_DEVICE} isn't a block device!"
    [ -z "${BOOT_LDR}" ] && _error "You need to choose a boot loader!"
    [ -z "${COUNTRY}" ] && _error "Missing country for generating mirrorlist!"
    [ -z "${USER}" ] && _error "No user was given for the sudo user!"
    [ ! -f "/usr/share/zoneinfo/${T_ZONE}" ] && _error "Unable to find timezone: ${T_ZONE}!"
    [ "${BOOT_LDR}" = "refind-efi" ] && [ ! -d /sys/firmware/efi ] && _error "${BOOT_LDR} isn't BIOS compatible."

    # Check required programs
    for p in $progs; do
        type -p "${p}" >/dev/null || _error "Missing required executable: ${p}"
    done
}

# Setup a GPT partition scheme
# 1: FAT32 formatted ESP
# 2: Ext4 formatted root partition
setup_gpt_scheme() {
    # Usage: _setup_gpt device
    local esp_part root_part

    esp_part="${PART_PREFIX}1"
    root_part="${PART_PREFIX}2"

    parted -s -a optimal "${BLOCK_DEVICE}" \
        mklabel gpt \
        mkpart primary fat32 0% 513MiB \
        mkpart primary ext4 513MiB 100% \
        set 1 esp on

    # Format
    mkfs.vfat -F32 -n boot "${esp_part}" > /dev/null 2>&1 
    mkfs.ext4 -F -L root "${root_part}" > /dev/null 2>&1

    # Mount
    mount "${root_part}" /mnt
    mkdir /mnt/boot
    mount "${esp_part}" /mnt/boot
}

# Setup a MBR partition scheme
# 1: Ext4 formatted root partition
setup_mbr_scheme() {
    # Usage: _setup_mbr device
    local root_part

    root_part="${PART_PREFIX}1"

    parted -s -a optimal "${BLOCK_DEVICE}" \
        mklabel msdos \
        mkpart primary ext4 0% 100%

    # Format
    mkfs.ext4 -F -L root "${root_part}" > /dev/null 2>&1

    # Mount
    mount "${root_part}" /mnt
}

# Install packages, configure env
setup_chroot() {
    # Usage: setup_chroot conf_file
    local mirrorlist pac_conf

    # Enable multilib support
    pac_conf=$(<"/etc/pacman.conf")
    printf "${pac_conf/\#\[multilib]$'\n'\#Include/[multilib]$'\n'Include}" > /etc/pacman.conf

    # Setup mirrorlist
    mirrorlist=$(curl -s "https://www.archlinux.org/mirrorlist/?country=${COUNTRY}&protocol=https&use_mirro_status=on")
    printf "${mirrorlist//\#Server/Server}" > /etc/pacman.d/mirrorlist
    pacman -Sy >/dev/null 2>&1

    # Install base environment
    pacstrap /mnt base base-devel linux linux-firmware dhcpcd git sudo $PKG_LIST $BOOT_LDR > /dev/null 2>&1

    # Gen fstab
    genfstab -U /mnt >> /mnt/etc/fstab

    cp "${WORK_DIR}/deploy.sh" /mnt/root/
}

# Cleanup, umount & reboot
cleanup() {
    rm /mnt/root/deploy.sh 2>/dev/null
    umount /mnt/boot /mnt 2>/dev/null
}

# Print error & exit
_error() {
    # Usage _error message
    printf "\e[91mERROR\e[m: ${1}\n" >&2
    exit 2
}

# Print error
_info() {
    # Usage _info message
    printf "\e[96m${1}\e[m\n" >&2
}

# Configure timesync & timezone
_cfg_time() {
    # Usage: _cfg_time timezone
    ln -sf "/usr/share/zoneinfo/${1}" /etc/localtime
    hwclock --systohc
    timedatectl set-ntp true
}

# Configure system language
_cfg_locale() {
    # Usage: _cfg_locale
    local tmp_locale

    tmp_locale=$(<"/etc/locale.gen")
    printf "${tmp_locals//\#en_US.UTF-8/en_US.UTF-8}\n" > /etc/locale.gen
    locale-gen > /dev/null

    printf "LANG=en_US.UTF-8\n" > /etc/locale.conf
}

# Configure keyboard for vconsole & X
_cfg_kbd() {
    # Usage: _cfg_kbd
    printf "KEYMAP=de-latin1-nodeadkeys\n" > /etc/vconsole.conf

    mkdir -p /etc/X11/xorg.conf.d/
    cat <<-EOF > /etc/X11/xorg.conf.d/20-keyboard.conf
	Section "InputClass"
	    Identifier "keyboard"
	    MatchIsKeyboard "yes"
	    Option "XkbLayout" "de"
	    Option "XkbVariant" "nodeadkeys"
	EndSection
	EOF
}
# Configure hostname, hosts, dhcpd
_cfg_network() {
    # Usage: _cfg_network hostname
    printf "${1}\n" > /etc/hostname
    printf "%-12s localhost\n" "127.0.0.1" "::1" > /etc/hosts
    systemctl enable dhcpcd.service > /dev/null
}

# Configure user with sudo privileges
_cfg_user() {
    # Usage: _cfg_user user
    useradd -m -s /bin/bash "${1}"
}

# Configure user dotfiles
_cfg_dotfiles() {
    # Usage: _cfg_dotfiles user dotfiles
    su - "${1}" <<-EOF
	curl -sO "${2/github/raw.githubusercontent}/master/install.sh"
	chmod 744 install.sh
	./install.sh ${2}
	EOF
}

# Install aur helper & packages
_install_aur() {
    # Usage: _install_aur user aur_pkgs
    local sudo_file

    sudo_file="/etc/sudoers.d/10-${1}"
    printf "${1} ALL=(ALL) NOPASSWD: ALL" > "${sudo_file}"

    su - "${1}" <<-EOF
    git clone https://aur.archlinux.org/yay.git ~/yay
    (cd ~/yay; makepkg --noconfirm -si > /dev/null 2>&1; rm -rf ~/yay)
    yay --noconfirm -S ${2} > /dev/null 2>&1
	EOF
}

# Allow sudo & specific commands
_cfg_sudo() {
    # Usage: _cfg_sudo user
    local sudo_file

    sudo_file="/etc/sudoers.d/10-${1}"
    printf "${1} ALL=(ALL) ALL\n${1} ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/mount,/usr/bin/umount\n" > "${sudo_file}"
    chmod 440 "${sudo_file}"
}

# Install rEFInd as bootloader
_install_refind() {
    # Usage: _install_refind device
    local uuid

    refind-install
    uuid=$(lsblk -no UUID "${1}2")

    cat <<-EOF > /boot/EFI/refind/refind.conf
	extra_kernel_version_strings linux

	menuentry "Arch Linux" {
	    icon /EFI/refind/icons/os_arch.png
	    loader /vmlinuz-linux
	    initrd /initramfs-linux.img
	    options "rw root=UUID=${uuid}"
	    submentry "Use fallback initrd" {
	        initrd /initramfs-linux-fallback.img
	    }
	    submenuentry "Boot to terminal" {
	        add_options "systemd.unit=multi-user.target"
	    }
	}
	EOF

    cat <<-EOF > /boot/refind_linux.conf
	"Boot using default options"    "root=PARTUUID=${uuid} rw add_efi_memmap initrd=/initramfs-%v.img"
	"Boot using fallback initramfs" "root=PARTUUID=${uuid} rw add_efi_memmap initrd=/initramfs-%v-fallback.img"
	"Boot to terminal               "root=PARTUUID=${uuid} rw add_efi_memmap initrd=/initramfs-%v.img systemd.unit=multi-user.target"
	EOF
}

# Install grub as bootloader
_install_grub() {
    # Usage: _install_grub device
    if [ -d /sys/firmware/efi ]; then
        pacman --noconfirm -S efibootmgr > /dev/null 2>&1
        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    else
        grub-install --target=i386-pc "${1}"
    fi

    grub-mkconfig -o /boot/grub/grub.cfg
}

# Perform full installation
main() {
    # Cleanup on exit
    trap cleanup EXIT INT

    # Check for prerequisits
    _info "\nChecking prerequisits:(1/4)"
    check_reqs

    # Set path to script
    WORK_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"

    # Kernel adds 'p' to the end if the device name ends on a digit
    [[ "${BLOCK_DEVICE: -1}" =~ ^[0-9]$ ]] && PART_PREFIX="${BLOCK_DEVICE}p" || PART_PREFIX="${BLOCK_DEVICE}"

    # Setup partition table for UEFI/BIOS
    _info "Setting up partitioning scheme:(2/4)"
    [ -d /sys/firmware/efi ] && setup_gpt_scheme || setup_mbr_scheme

    _info "Setting up mirrors & installing packages:(3/4)"
    setup_chroot

    _info "Performing system configuration:(4/4)"
    arch-chroot /mnt /root/deploy.sh -c $@

    printf "\e[92mFinished installation:\e[m Please remove the ISO, reboot and then set appropriate passwords!\n" >&2

    exit 0
}

# Configure inside of chroot via library
main_configure() {
    # Kernel adds 'p' to the end if the device name ends on a digit
    [[ "${BLOCK_DEVICE: -1}" =~ ^[0-9]$ ]] && PART_PREFIX="${BLOCK_DEVICE}p" || PART_PREFIX="${BLOCK_DEVICE}"

    _cfg_time "${T_ZONE}"
    _cfg_locale
    [ $COUNTRY = 'DE' ] && _cfg_kbd
    _cfg_network "${HOST}"
    _cfg_user "${USER}"
    _cfg_dotfiles "${USER}" "${DOTFILES}"
    _install_aur "${USER}" "${AUR_LIST}"
    _cfg_sudo "${USER}"
    [ "${BOOT_LDR}" = "refind-efi" ] && _install_refind "${PART_PREFIX}" || _install_grub "${BLOCK_DEVICE}"

    exit 0
}

args="$@"

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -b|--device)
            BLOCK_DEVICE="$2"
            shift
            shift
            ;;
        -c|--configure)
            CONF=true
            shift
            ;;
        -d|--dotfiles)
            DOTFILES="$2"
            shift
            shift
            ;;
        -i|--country)
            COUNTRY="$2"
            shift
            shift
            ;;
        -n|--name)
            HOST="$2"
            shift
            shift
            ;;
        -l|--bootloader)
            BOOT_LDR="$2"
            shift
            shift
            ;;
        -t|--timezone)
            T_ZONE="$2"
            shift
            shift
            ;;
        -u|--username)
            USER="$2"
            shift
            shift
            ;;
        *)
            _error "Unkown option $1 was given."
            shift
            ;;
   esac
done

if [ "${CONF}" = true ]; then
    main_configure
else
    printf "\e[91mWARNING:\e[0m All data stored on \e[91m\"${BLOCK_DEVICE}\"\e[0m will be overwritten!\n"
    read -p "Proceed with installation? [Y/n]" -n 1 -r
    if [ $REPLY = Y ]; then
        main "${args}"
    fi
fi
