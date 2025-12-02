#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Backup existing file/directory if it exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing $target${NC}"
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi

    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Create symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓${NC} Linked $source -> $target"
}

# Install gitconfig
create_symlink "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

# Install zshrc
create_symlink "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

# Install bin directory
mkdir -p "$HOME/bin"
for file in "$DOTFILES_DIR/bin"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        create_symlink "$file" "$HOME/bin/$filename"
        chmod +x "$file"
    fi
done

# Install config files
create_symlink "$DOTFILES_DIR/config/zed" "$HOME/.config/zed"

echo ""
echo -e "${GREEN}Dotfiles installation complete!${NC}"
echo ""
echo "Note: Make sure $HOME/bin is in your PATH."
echo "Add this to your shell config if needed:"
echo "  export PATH=\"\$HOME/bin:\$PATH\""

if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "Backup of existing files created at: $BACKUP_DIR"
fi
