#!/usr/bin/env bash

export RESTIC_REPOSITORY="/storage/restic-repo"
export RESTIC_PASSWORD_FILE="$HOME/.config/backup/.restic-password"

restic backup --files-from ~/.config/backup/include.txt
restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75 --prune
restic check | tee -a /var/log/restic.log
