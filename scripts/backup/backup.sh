#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
CONFIG_VARS="RESTIC_REPOSITORY RESTIC_PASSWORD_FILE FILES"

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

check() {
    [ "$EUID" -ne 0 ] && error "Script must be executed as root!"

    ! type -p restic 2>&1 >/dev/null && error "Missing restic binary, please ensure it is installed!"

    [ ! -f "${SCRIPT_DIR}/config.sh" ] && error "Missing configuration file!"

    source "${SCRIPT_DIR}/config.sh"
    for var in $CONFIG_VARS; do
        if [ -z "${!var}" ]; then
            error "Please configure a value for ${var} in the config.sh!"
        fi
    done
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

    PASSWORD_DIR=$(dirname "$RESTIC_PASSWORD_FILE")
    [ ! -d "${PASSWORD_DIR}" ] && mkdir -p "${PASSWORD_DIR}"
    echo "$password" > "$RESTIC_PASSWORD_FILE"
    printf 'Init new restic repository!\n'
    mkdir -p "$RESTIC_REPOSITORY"
    restic init

    printf 'Setup crontab!\n'
    SCRIPT_NAME="$(basename $0)"
	cat <<-EOF >> /etc/cron.d/restic
	30 10 * * * root ${SCRIPT_DIR}/${SCRIPT_NAME} -r
	30 20 * * * root ${SCRIPT_DIR}/${SCRIPT_NAME} -r
	EOF

    exit 0
}

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -s|--setup)
            check
            setup
            ;;
        -r|--run)
            check
            run ${FILES[@]}
            ;;
        *)
            error "Unkown option $1 was given. See -h|--help for available options."
            ;;
   esac
done
