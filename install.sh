#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create symlinks
ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

# Copy template files
cp "$DOTFILES_DIR/latexmkrc.template" "$HOME/.latexmkrc"
cp "$DOTFILES_DIR/envrc.template" "$HOME/.envrc"

echo "Installation complete. Run 'direnv allow' to activate .envrc"
