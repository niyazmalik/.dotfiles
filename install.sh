#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
CONFIG="$HOME/.config"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "linked $dst"
}

# nvim
link "$DOTFILES/nvim" "$CONFIG/nvim"

# alacritty
link "$DOTFILES/alacritty/alacritty.toml" "$CONFIG/alacritty/alacritty.toml"

# tmux
link "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# bash
link "$DOTFILES/bash/bashrc" "$HOME/.bashrc"
for f in "$DOTFILES/bash/config/"*.sh; do
    link "$f" "$CONFIG/bash/$(basename "$f")"
done

# starship
link "$DOTFILES/starship/starship.toml" "$CONFIG/starship.toml"
