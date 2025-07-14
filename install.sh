#!/bin/bash

# Speedy Delivery Installer
# This script installs speedy-delivery to your system

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="speedy-delivery"
INSTALL_DIR="/usr/local/bin"

echo "🚀 Installing Speedy Delivery..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This tool is designed for macOS only."
    exit 1
fi

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "⚠️  Warning: fswatch is not installed."
    echo "Please install it first:"
    echo "  brew install fswatch"
    echo ""
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Make the script executable
chmod +x "$SCRIPT_DIR/$SCRIPT_NAME"

# Create symlink
echo "📦 Installing to $INSTALL_DIR..."
if [[ -L "$INSTALL_DIR/$SCRIPT_NAME" ]]; then
    echo "🔄 Updating existing symlink..."
    rm "$INSTALL_DIR/$SCRIPT_NAME"
fi

sudo ln -sf "$SCRIPT_DIR/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"

# Create default watch directory
DEFAULT_WATCH_DIR="$HOME/Desktop/watch_images"
if [[ ! -d "$DEFAULT_WATCH_DIR" ]]; then
    echo "📁 Creating default watch directory: $DEFAULT_WATCH_DIR"
    mkdir -p "$DEFAULT_WATCH_DIR"
fi

echo "✅ Installation complete!"
echo ""
echo "Usage:"
echo "  $SCRIPT_NAME                    # Watch default directory"
echo "  $SCRIPT_NAME ~/Downloads        # Watch specific directory"
echo "  $SCRIPT_NAME --help             # Show help"
echo ""
echo "Default watch directory: $DEFAULT_WATCH_DIR"
echo "Log file: ~/Library/Logs/speedy-delivery.log"