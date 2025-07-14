# Speedy Delivery

A macOS utility that watches folders for new image and PDF files and automatically opens them in Preview.

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
git clone https://github.com/yourusername/speedy-delivery.git
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

1. Uses `fswatch` to monitor specified directories for file system events
2. Filters events to only process supported file types
3. Implements a simple cache mechanism to prevent duplicate file openings
4. Plays the macOS "Submarine" sound when opening files
5. Logs all activities for debugging

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Uses `fswatch` for efficient file system monitoring
- Inspired by the need for quick image preview workflows
- Built with comprehensive testing and documentation standards