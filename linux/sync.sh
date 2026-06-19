#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

sync_back() {
    local name="$1"
    local src="$HOME/.config/$name"
    local dest="$ROOT/linux/$name"

    if [ -L "$src" ]; then
        echo "Skipping $name: ~/.config/$name is a symlink (already points to the repo)"
        return
    fi

    if [ ! -d "$src" ]; then
        echo "Skipping $name: ~/.config/$name does not exist"
        return
    fi

    rm -rf "$dest"
    cp -r "$src" "$dest"
    echo "Updated $dest from ~/.config/$name"
}

sync_back nvim
sync_back hypr
sync_back waybar
sync_back neofetch

