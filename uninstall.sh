#!/bin/bash

# Speedy Delivery Uninstaller
# This script removes speedy-delivery from your system

set -e

SCRIPT_NAME="speedy-delivery"
INSTALL_DIR="/usr/local/bin"

echo "🗑️  Uninstalling Speedy Delivery..."

# Remove symlink
if [[ -L "$INSTALL_DIR/$SCRIPT_NAME" ]]; then
    echo "🔗 Removing symlink from $INSTALL_DIR..."
    sudo rm "$INSTALL_DIR/$SCRIPT_NAME"
    echo "✅ Symlink removed"
else
    echo "ℹ️  No symlink found in $INSTALL_DIR"
fi

# Ask about removing cache and logs
echo ""
read -p "Remove cache and log files? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    CACHE_DIR="$HOME/.cache/speedy-delivery"
    LOG_FILE="$HOME/Library/Logs/speedy-delivery.log"

    if [[ -d "$CACHE_DIR" ]]; then
        echo "🗂️  Removing cache directory..."
        rm -rf "$CACHE_DIR"
        echo "✅ Cache removed"
    fi

    if [[ -f "$LOG_FILE" ]]; then
        echo "📝 Removing log file..."
        rm "$LOG_FILE"
        echo "✅ Log file removed"
    fi
fi

# Ask about removing default watch directory
echo ""
read -p "Remove default watch directory (~/Desktop/watch_images)? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    DEFAULT_WATCH_DIR="$HOME/Desktop/watch_images"
    if [[ -d "$DEFAULT_WATCH_DIR" ]]; then
        echo "📁 Removing default watch directory..."
        rm -rf "$DEFAULT_WATCH_DIR"
        echo "✅ Watch directory removed"
    fi
fi

echo ""
echo "✅ Uninstallation complete!"
echo "Note: The original script file in this directory was not removed."