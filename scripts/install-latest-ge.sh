#!/usr/bin/env bash

json=$(curl -s 'https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest')
[[ $json =~ .*(https.*\.tar\.gz).* ]] && url="${BASH_REMATCH[1]}"
filename="${url##*/}"
steam_dir=$HOME/.steam/root/compatibilitytools.d
mkdir -p "$steam_dir"
cd "$steam_dir"
curl -sLO "$url"
hash=$(curl -Lf ${url//.tar.gz/.sha512sum})
if printf '%s' "${hash%% *} ${filename}" | sha512sum -c -; then
    tar -xf "$filename"
fi

rm "$filename"
