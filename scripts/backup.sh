#!/usr/bin/env bash

export RESTIC_REPOSITORY="/storage/hdd/restic-repo"
export RESTIC_PASSWORD_FILE="/root/.config/.restic"
FILES=(
    /home/saiba/.minecraft/saves
    /home/saiba/.mozilla/firefox/*.default*
    /home/saiba/.ssh
    /home/saiba/.thunderbird/*.default*
    /home/saiba/.ts3client/{chats,identity.ini,settings.db,urls.db}
    /home/saiba/Documents
    /home/saiba/Downloads
    /storage/hdd/virtual-machines/
)

usage() {
    cat <<-EOF
	Usage: $(basename "$0") [options]

	Options:
	-h, --help      Show this help message.
	-r, --run       Execute backup of target files, prune old backups afterwards and check backup integrity.
	-s, --setup     Setup password file, init repository and create cron entry.
	EOF

    exit 1
}

error() {
    printf '\e[93mERROR:\e[m %s\n' "${1}"
    exit 2
}

check_root() {
    [ "$EUID" -ne 0 ] && error "Script must be executed as root!"
}

run() {
    HOSTNAME=$(uname -n)
    restic backup -vv --tag "${HOSTNAME}" $@
    restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 24 --prune
    restic check | tee -a /var/log/restic.log

    exit 0
}

setup() {
    [ -f "$RESTIC_PASSWORD_FILE" ] && error "Password file already exists. Aborting setup!"

    printf 'Password:\n'
    read -s password
    printf 'Confirm Password:\n'
    read -s password_confirmation
    [[ "${password}" != "${password_confirmation}" ]] && error "Passwords do not match!"

    CONFIG_DIR=$(dirname "$RESTIC_PASSWORD_FILE")
    [ ! -d "${CONFIG_DIR}" ] && mkdir -p "${CONFIG_DIR}"
    echo "$password" > "$RESTIC_PASSWORD_FILE"
    printf 'Init new restic repository!\n'
    mkdir -p "$RESTIC_REPOSITORY"
    restic init

    printf 'Setup crontab!\n'
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
    SCRIPT_NAME="$(basename $0)"
    echo "0 12 * * * root ${SCRIPT_DIR}/${SCRIPT_NAME} -r" > /etc/cron.d/restic

    exit 0
}

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -s|--setup)
            check_root
            setup
            ;;
        -r|--run)
            check_root
            run ${FILES[@]}
            ;;
        *)
            error "Unkown option $1 was given. See -h|--help for available options."
            ;;
   esac
done
