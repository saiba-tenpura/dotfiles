#!/usr/bin/env bash

shopt -s nullglob

# Source config with base_target & sources
source $1

# Copy documents, pictures and videos
declare -A type_to_extension=([Audio]='*.aac *.wav' [Documents]='*.json *.md *.opus *.pdf *.stl *.txt *.vcf *.zip' [Pictures]='*.bmp *.gif *.jpg *.jpeg *.png *.tgs *.tif *.tiff *.webp' [Videos]='*.mp4 *.webm')
for source in "${sources[@]}"; do
    printf 'Dir: %s \n' "${source}"
    cd "$source"
    for type in "${!type_to_extension[@]}"; do 
        printf 'Type: %s \n' "${type}"
        for file in ${type_to_extension[$type]}; do
            mod_date="$(date +%F -r "${file}")"
            year="${mod_date:0:4}"
            mkdir -p "$base_target/$year/$type"
            printf 'File: %s to %s \n' "${file}" "$base_target/$year/$type" 
            rsync -avz "$file" "$base_target/$year/$type" > /dev/null
        done

        printf '\n'
    done

    printf '\n'
done

printf 'Finished copying!\n'
