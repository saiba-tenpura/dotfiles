#!/usr/bin/env bash

export RESTIC_REPOSITORY="/var/backups/restic-repo"
export RESTIC_PASSWORD_FILE="/root/.config/.restic"
export FILES=(
    /home/saiba/
)
