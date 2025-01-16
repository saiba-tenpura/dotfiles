#!/usr/bin/env bash

BACKUP_BASE_DIR="/var/backups/docker-db-dumps/"

usage() {
    cat <<-EOF
    Usage: $(basename "$0") [options]

        Options:
        -h, --help      Show this help message.
        -d, --daily     Run daily backup and cleanup functionality.
        -m, --monthly   Run monthly backup and cleanup functionality.
        EOF

    exit 1
}

run_backup() {
    BACKUP_DIR="$1"
    RETENTION_AMOUNT=$2
    DATE=$(date +%Y-%m-%d)

    # Get all MySQL containers
    mysql_images=$(docker images --filter "reference=mysql:*" -q)
    mysql_containers=$(for hash in $mysql_images; do docker ps --filter "ancestor=$hash" -q; done)
    for container in $mysql_containers; do
        # Get compose project name
        project=$(docker inspect --format='{{ index .Config.Labels "com.docker.compose.project"}}' $container)

        # Backup MySQL database
        mkdir -p "${BACKUP_DIR}/${DATE}/${project}"
        databases=$(docker exec $container bash -c 'mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "show databases" -s --skip-column-names | grep -Ev "(sys|information_schema|performance_schema)"')
        for db in $databases; do
            docker exec $container bash -c 'mysqldump -u root --password="$MYSQL_ROOT_PASSWORD" --opt $1' -- "${db}" | bzip2 --best > "${BACKUP_DIR}/${DATE}/${project}/${db}.sql.bz2"
        done

        # Cleanup old backups
        ls -dt "${BACKUP_DIR}/"* | tail -n +$RETENTION_AMOUNT | xargs -I {} rm -rf -- {}
    done
    exit
}

error() {
    printf '\e[93mERROR:\e[m %s\n' "${1}"
    exit 2
}

if [[ $# -eq 0 ]] ; then
    error "No options were given. See -h|--help for available options."
fi

if [[ "$EUID" -ne 0 ]]; then
    error "Please run this script as root!"
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -d|--daily)
            run_backup "${BACKUP_BASE_DIR}/daily" 15
            ;;
        -m|--monthly)
            run_backup "${BACKUP_BASE_DIR}/monthly" 13
            ;;
        *)
            error "Unsupported option $1 was given. See -h|--help for available options."
            ;;
    esac
done
