# Speedy Delivery

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS-blue.svg)]()

A macOS utility that watches folders for new image and PDF files and automatically opens them in Preview.

## Why Speedy Delivery?

- **Learning project**: Built to understand file system monitoring and macOS automation
- **Practical utility**: Automatically opens new images and PDFs in Preview
- **Smart design**: Prevents duplicate openings with intelligent throttling
- **Well-documented**: Comprehensive testing, documentation, and development tools

## Features

- **Real-time monitoring**: Watches specified directories for new files
- **Smart throttling**: Prevents duplicate file openings with configurable cache TTL
- **Audio feedback**: Plays a system sound when files are opened
- **Comprehensive logging**: All events are logged for debugging
- **Multiple file types**: Supports images (JPG, PNG, WebP, GIF, HEIC) and PDFs

## Requirements

- macOS (uses `fswatch` and `afplay`)
- `fswatch` command-line tool

## Installation

### Install fswatch

First, install the required `fswatch` tool:

```bash
# Using Homebrew (recommended)
brew install fswatch

# Or using MacPorts
sudo port install fswatch
```

### Install Speedy Delivery

1. Clone this repository:
```bash
git clone https://github.com/funkatron/speedy-delivery.git
cd speedy-delivery
```

2. Install using the Makefile (recommended):
```bash
make install
```

Or install manually:
```bash
# Make the script executable
chmod +x speedy-delivery

# Add to your PATH
sudo ln -s "$(pwd)/speedy-delivery" /usr/local/bin/speedy-delivery
```

Or use the installation script:
```bash
./install.sh
```

## Getting Started

1. **Install dependencies**:
   ```bash
   brew install fswatch
   ```

2. **Clone and install**:
   ```bash
   git clone https://github.com/funkatron/speedy-delivery.git
   cd speedy-delivery
   make install
   ```

3. **Start watching**:
   ```bash
   speedy-delivery ~/Downloads
   ```

4. **Test it**: Drop an image or PDF into `~/Downloads` and watch it open automatically!

## Development

The project includes a comprehensive Makefile for common tasks:

```bash
make help          # Show all available commands
make test-clean    # Run comprehensive tests
make smoke-test    # Demonstrate functionality
make lint          # Check script syntax
make install       # Install to system
make uninstall     # Remove from system
```

## Usage

### Basic Usage

Watch the default directory (`~/Desktop/watch_images`):
```bash
./speedy-delivery
```

### Watch Specific Directories

Watch one or more directories:
```bash
./speedy-delivery ~/Downloads ~/Desktop/screenshots
```

### Help

Show usage information:
```bash
./speedy-delivery --help
```

## Examples

### Example 1: Watch Downloads Folder
```bash
# Start watching your Downloads folder
speedy-delivery ~/Downloads

# Now when you download images or PDFs, they'll open automatically!
# Try downloading a screenshot or PDF to see it in action
```

### Example 2: Watch Multiple Folders
```bash
# Watch both Downloads and a screenshots folder
speedy-delivery ~/Downloads ~/Desktop/screenshots

# Files in either folder will be opened automatically
```

### Example 3: Development Workflow
```bash
# Watch a project's assets folder
speedy-delivery ~/my-project/assets

# When you save images from your design tools, they open instantly
# Great for reviewing design assets as you work
```

### Example 4: Testing the Tool
```bash
# Run the smoke test to see it work
make smoke-test

# Or test in isolation
./test/clean-test.sh
```

### Example 5: Debug Mode
```bash
# Start the tool and watch logs in real-time
speedy-delivery ~/Downloads &
tail -f ~/Library/Logs/speedy-delivery.log

# Now drop files and watch the logs show what's happening
```

## Configuration

### Cache TTL

The script ignores files that were opened within the last 10 seconds to prevent duplicate launches. You can modify this by changing the `CACHE_TTL` variable in the script.

### Logging

All events are logged to `~/Library/Logs/speedy-delivery.log`. Check this file for debugging information.

### Cache Directory

File timestamps are cached in `~/.cache/speedy-delivery/` to implement the throttling mechanism.

## Best Practices

### 1. **Use Specific Directories**
```bash
# Good: Watch specific folders
speedy-delivery ~/Downloads ~/Desktop/screenshots

# Avoid: Watching entire home directory
speedy-delivery ~
```

### 2. **Run in Background for Long Sessions**
```bash
# Start in background
speedy-delivery ~/Downloads &
SPEEDY_PID=$!

# Stop when done
kill $SPEEDY_PID
```

### 3. **Monitor Logs During Development**
```bash
# Watch logs while testing
tail -f ~/Library/Logs/speedy-delivery.log
```

### 4. **Test Before Production Use**
```bash
# Always test in a safe directory first
mkdir ~/test-watch
speedy-delivery ~/test-watch
# Drop test files here first
```

### 5. **Use the Makefile for Development**
```bash
# Run comprehensive tests
make test-clean

# See it in action
make smoke-test

# Check syntax
make lint
```

## Supported File Types

- **Images**: `.jpg`, `.jpeg`, `.png`, `.webp`, `.gif`, `.heic`
- **Documents**: `.pdf`

## How It Works

Speedy Delivery uses a simple but effective approach:

1. **File Watching**: Uses `fswatch` to monitor directories for new files
2. **Smart Filtering**: Only processes supported image and PDF files
3. **Duplicate Prevention**: Caches file timestamps to avoid opening the same file twice
4. **User Feedback**: Plays a sound and opens files in Preview
5. **Logging**: Records all activity for troubleshooting

## What I Learned Building This

### File System Monitoring
- **fswatch**: A powerful tool for cross-platform file system events
- **Event filtering**: How to filter events to only process relevant files
- **Process management**: Running background processes and cleanup

### macOS Integration
- **afplay**: Playing system sounds programmatically
- **open command**: Launching applications from the command line
- **Preview.app**: macOS's default image/PDF viewer

### Bash Scripting Best Practices
- **Error handling**: Using `set -e` and proper exit codes
- **Variable quoting**: Always quote variables to handle spaces
- **Process management**: Background processes and signal handling
- **Logging**: Structured logging with timestamps
- **Caching**: Simple file-based caching for throttling

### Testing and Documentation
- **Isolated testing**: Using `/tmp` directories for clean tests
- **Comprehensive documentation**: README, CONTRIBUTING, CHANGELOG
- **Development tools**: Makefile for common tasks
- **Cursor rules**: AI-assisted development guidelines

## Troubleshooting

### Common Issues

1. **"fswatch: command not found"**
   - Install fswatch using Homebrew: `brew install fswatch`

2. **Files not opening**
   - Check the log file: `cat ~/Library/Logs/speedy-delivery.log`
   - Ensure the file types are supported
   - Verify file permissions

3. **Too many files opening**
   - Increase the `CACHE_TTL` value in the script
   - Check if multiple instances are running

### Debug Mode

To see what's happening in real-time, you can run:
```bash
tail -f ~/Library/Logs/speedy-delivery.log
```

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

Quick start:
1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test thoroughly: `make test-clean`
5. Commit your changes: `git commit -am 'feat: add feature description'`
6. Push to the branch: `git push origin feature-name`
7. Submit a pull request

## Quick Demo

See Speedy Delivery in action:
```bash
# Clone and test
git clone https://github.com/funkatron/speedy-delivery.git
cd speedy-delivery
make smoke-test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Uses `fswatch` for efficient file system monitoring
- Inspired by the need for quick image preview workflows
- Built with comprehensive testing and documentation standards