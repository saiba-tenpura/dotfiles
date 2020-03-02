#!/usr/bin/env bash

# BLOCK_DEVICE    Target block device for installation.
# BOOT_LDR        Bootloader to use. Supported options are BIOS: grub UEFI: grub refind-efi
# COUNTRY         Country used for mirrorlist generation.
# DOTFILES        Repository containing user dotfiles.
# PKG_LIST        List of packages to add to base installation. (Included by Default: dhcpcd, git, sudo)
# HOST            Hostname for the system.
# USER            Name of sudo user to create.
# T_ZONE          Timezone of the system. (i.e. '/usr/share/zoneinfo/${T_ZONE}')
# KBD_LAYOUT      Keyboard layout.

BLOCK_DEVICE="/dev/sda"
BOOT_LDR="refind-efi"
COUNTRY="DE"
DOTFILES="https://github.com/aynsoph/dotfiles.git"
PKG_LIST="bspwm openssh sxhkd neovim xorg-server xorg-xinit ${BOOT_LDR}"
HOST="alpha"
USER="aynsoph"
T_ZONE="Europe/Berlin"
KBD_LAYOUT="de-latin1-nodeadkeys"

# Print usage info && exit
usage() {
    cat <<-EOF
	Usage: $(basename "${0}") [-h|--help] [-b|--device BLOCK_DEVICE] [-d|--dotfiles DOTFILES]

	Flags:
	-h, --help   Show this help message.

	Options:
	-b, --device <block_device>    Block device to install to.
	-d, --dotfiles <repo_url>      Dotfiles repository to install.

	Additional configuration options are contained and explained within the script itself.
	For only setting up dotfiles run this script without any parameters.
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
    mkfs.vfat -F32 -n boot "${esp_part}"
    mkfs.ext4 -L root "${root_part}"

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
    mkfs.ext4 -F -L root "${root_part}"

    # Mount
    mount "${root_part}" /mnt
}

# Install packages, configure env, cleanup
setup_chroot() {
    # Usage: setup_chroot conf_file
    local mirrorlist

    # Setup mirrorlist
    mirrorlist=$(curl -s "https://www.archlinux.org/mirrorlist/?country=${COUNTRY}&protocol=https&use_mirro_status=on")
    printf "${mirrorlist//\#Server/Server}" > /etc/pacman.d/mirrorlist
    pacman -Su >/dev/null 2>&1

    # Install base environment
    pacstrap /mnt base linux linux-firmware dhcpcd git sudo ${PKG_LIST}

    # Gen fstab
    genfstab -U /mnt >> /mnt/etc/fstab

    cp "${WORK_DIR}/install.sh" /mnt/root/
}


# Cleanup, umount & reboot
cleanup() {
    rm /mnt/root/install.sh
    umount /mnt/boot /mnt
}

# Print error & exit
_error() {
    # Usage _error message
    printf "\e[91mERROR\e[m: ${1}\n" >&2
    exit 2
}

# Configure timesync & timezone
_cfg_time() {
    # Usage: cfg_time timezone
    ln -sf /usr/share/zoneinfo/"${1}" /etc/localtime
    hwclock --systohc
    timedatectl set-ntp true
}

# Configure system language
_cfg_locale() {
    # Usage: cfg_locale keyboard
    local tmp_locale

    tmp_locale=$(<"/etc/locale.gen")
    printf "${tmp_locals//\#en_US.UTF-8/en_US.UTF-8}\n" > /etc/locale.gen
    locale-gen

    printf "LANG=en_US.UTF-8\n" > /etc/locale.conf
    [ -n "${1}" ] && printf "KEYMAP=de-latin1-nodeadkeys\n" > /etc/vconsole.conf
}

# Configure hostname, hosts, dhcpd
_cfg_network() {
    # Usage: cfg_network hostname
    printf "${1}\n" > /etc/hostname
    printf "%-12s localhost\n" "127.0.0.1" "::1" > /etc/hosts
    systemctl enable dhcpcd.service
}

# Disable root login, only allow $USER
_cfg_openssh() {
    # Usage: cfg_openssh user
    local tmp_sshd

    tmp_sshd=$(<"/etc/ssh/sshd_config")
    printf "${tmp_sshd//\#PermitRootLogin prohibit-password/PermitRootLogin no}\n" > /etc/ssh/sshd_config
    printf "AllowUsers ${1}\n" >> /etc/ssh/sshd_config
}

# Configure user with sudo privileges &
# get dotfiles if available
_cfg_user() {
    # Usage: cfg_user user
    local sudo_file

    sudo_file="/etc/sudoers.d/10-${1}"
    useradd -m -s /bin/bash "${1}"
    printf "${1} ALL=(ALL) ALL\n" >> "${sudo_file}"
    chmod 440 "${sudo_file}"
}

# Configure user dotfiles
_cfg_dotfiles() {
    # Usage: cfg_dotfiles user dotfiles
    su - ${user} <<-EOF
	curl ${dotfiles}/master/install.sh
	install.sh ${dotfiles}
	EOF
}

# Install rEFInd as bootloader
_install_refind() {
    # Usage: install_refind device
    local cfg uuid

    refind-install
    uuid=$(lsblk -no UUID "${1}2")

    read -r -d '' cfg <<-EOF
    menuentry "Arch Linux" {
       loader /vmlinuz-linux
        initrd /initramfs-linux.img
        options "rw root=UUID=${uuid}"
        submentry "Use fallback initrd" {
            initrd /initramfs-linux-fallback.img
        }
    }
    EOF

    printf "${cfg}" > /boot/EFI/refind/refind.conf
}

# Install grub as bootloader
_install_grub() {
    # Usage: install_grub device
    [ -d /sys/firmware/efi ] && grub-install --target=i386-pc "${1}" || \
        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
}

main() {
    check_reqs

    # Set path to script
    WORK_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"

    # Kernel adds 'p' to the end if the device name ends on a digit
    [[ "${BLOCK_DEVICE: -1}" =~ ^[0-9]$ ]] && PART_PREFIX="${BLOCK_DEVICE}p" || PART_PREFIX="${BLOCK_DEVICE}"

    # Setup partition table for UEFI/BIOS
    [ -d /sys/firmware/efi ] && setup_gpt_scheme || setup_mbr_scheme

    setup_chroot
    arch-chroot /mnt /root/install.sh -c
    cleanup

    cat <<-EOF >&2
	$(tput setaf 2)Finished installation:$(tput sgr0)
	Please remove ISO, reboot and then set appropriate passwords!
	EOF

    exit 0
}

# Configure inside of chroot via library
main_configure() {
    _cfg_time "${T_ZONE}"
    _cfg_locale "${KBD_LAYOUT}"
    _cfg_network
    _cfg_openssh "${USER}"

    _cfg_user "${USER}"
    _cfg_dotfiles "${USER}" "${DOTFILES}"
    [ "${BOOT_LDR}" = "refind-efi" ] && _install_refind "${PART_PREFIX}" "${BOOT_LDR_REPO}" || _install_grub "${BLOCK_DEVICE}"
}

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
            CONF='true'
            ;;
        -d|--dotfiles)
            DOTFILES="$2"
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
    main_configure "$@"
else
    main "$@"
fi
