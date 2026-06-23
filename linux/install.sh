#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

ln -sf "$ROOT/linux/fish" ~/.config/fish
ln -sf "$ROOT/linux/hypr" ~/.config/hypr
ln -sf "$ROOT/linux/neofetch" ~/.config/neofetch
ln -sf "$ROOT/linux/nvim" ~/.config/nvim
ln -sf "$ROOT/linux/rofi" ~/.config/rofi
ln -sf "$ROOT/linux/swaync" ~/.config/swaync
ln -sf "$ROOT/linux/waybar" ~/.config/waybar
