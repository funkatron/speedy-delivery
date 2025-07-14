# Speedy Delivery

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS-blue.svg)]()

A macOS utility that watches folders for new image and PDF files and automatically opens them in Preview.

## Why Speedy Delivery?

- **Save time**: No more manually opening files after downloads
- **Stay focused**: Automatic preview keeps your workflow smooth
- **Smart**: Prevents duplicate openings with intelligent throttling
- **Reliable**: Comprehensive logging for debugging

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

2. Make the script executable:
```bash
chmod +x speedy-delivery
```

3. (Optional) Add to your PATH by creating a symlink:
```bash
sudo ln -s "$(pwd)/speedy-delivery" /usr/local/bin/speedy-delivery
```

Or use the provided installation script:
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
   ./install.sh
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

## Configuration

### Cache TTL

The script ignores files that were opened within the last 10 seconds to prevent duplicate launches. You can modify this by changing the `CACHE_TTL` variable in the script.

### Logging

All events are logged to `~/Library/Logs/speedy-delivery.log`. Check this file for debugging information.

### Cache Directory

File timestamps are cached in `~/.cache/speedy-delivery/` to implement the throttling mechanism.

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