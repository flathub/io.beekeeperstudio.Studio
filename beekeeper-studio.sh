#!/bin/sh

set -oue pipefail
export TMPDIR="${XDG_RUNTIME_DIR}/app/${FLATPAK_ID}"

FLAGS=''
if [[ $XDG_SESSION_TYPE == "wayland" && -e "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]]
then
    FLAGS="$FLAGS --enable-wayland-ime --ozone-platform-hint=wayland --enable-features=WaylandWindowDecorations --gtk-version=4"
    if  [ -c /dev/nvidia0 ]
    then
        FLAGS="$FLAGS --disable-gpu-sandbox"
    fi
fi

exec zypak-wrapper /app/beekeeper-studio/beekeeper-studio-bin $FLAGS "$@"
