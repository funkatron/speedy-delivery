#!/bin/bash

# Automated macOS VM setup for testing Speedy Delivery
# This script creates a clean VM environment for testing

set -e

echo "🚀 Setting up macOS VM for testing..."

# Check if UTM is available
if ! command -v utm &> /dev/null; then
    echo "📦 Installing UTM..."
    brew install --cask utm
fi

# Create test directory
TEST_DIR="$HOME/speedy-delivery-test"
echo "📁 Creating test directory: $TEST_DIR"
mkdir -p "$TEST_DIR"

# Copy project files to test directory
echo "📋 Copying project files..."
cp -r . "$TEST_DIR/"

# Create VM configuration
echo "⚙️  Creating VM configuration..."
cat > "$TEST_DIR/vm-config.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>UTM</key>
    <dict>
        <key>VM</key>
        <dict>
            <key>Name</key>
            <string>Speedy Delivery Test</string>
            <key>Notes</key>
            <string>Clean macOS environment for testing Speedy Delivery</string>
            <key>Architecture</key>
            <string>arm64</string>
            <key>Platform</key>
            <string>macOS</string>
            <key>CPUCount</key>
            <integer>2</integer>
            <key>MemorySize</key>
            <integer>4096</integer>
            <key>DiskSize</key>
            <integer>51200</integer>
            <key>BootDevice</key>
            <string>CD</string>
            <key>Display</key>
            <dict>
                <key>Width</key>
                <integer>1920</integer>
                <key>Height</key>
                <integer>1080</integer>
            </dict>
        </dict>
    </dict>
</dict>
</plist>
EOF

# Create test script for VM
echo "📝 Creating test script..."
cat > "$TEST_DIR/test-in-vm.sh" << 'EOF'
#!/bin/bash

# Test script to run inside the VM
set -e

echo "🧪 Testing Speedy Delivery in clean environment..."

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install fswatch
echo "📦 Installing fswatch..."
brew install fswatch

# Navigate to project directory
cd ~/speedy-delivery

# Test installation
echo "🔧 Testing installation..."
./install.sh

# Test functionality
echo "🧪 Testing functionality..."
speedy-delivery --help

# Test file watching
echo "👀 Testing file watching..."
mkdir -p ~/Desktop/test-watch
speedy-delivery ~/Desktop/test-watch &
SPEEDY_PID=$!

# Create test files
echo "📄 Creating test files..."
echo "test content" > ~/Desktop/test-watch/test.jpg
echo "test content" > ~/Desktop/test-watch/test.pdf

# Wait and check logs
sleep 3
echo "📋 Checking logs..."
tail -n 5 ~/Library/Logs/speedy-delivery.log

# Cleanup
kill $SPEEDY_PID 2>/dev/null || true

echo "✅ Test completed successfully!"
EOF

chmod +x "$TEST_DIR/test-in-vm.sh"

# Create VM startup script
echo "🚀 Creating VM startup script..."
cat > "$TEST_DIR/start-vm.sh" << 'EOF'
#!/bin/bash

# Start the test VM
echo "🚀 Starting Speedy Delivery test VM..."

# Check if UTM is installed
if ! command -v utm &> /dev/null; then
    echo "❌ UTM not found. Installing..."
    brew install --cask utm
fi

# Open UTM with our configuration
echo "📱 Opening UTM..."
open -a UTM

echo ""
echo "📋 Next steps:"
echo "1. In UTM, create a new macOS VM"
echo "2. Install macOS in the VM"
echo "3. Copy the test directory to the VM"
echo "4. Run: ./test-in-vm.sh"
echo ""
echo "Test directory: $TEST_DIR"
EOF

chmod +x "$TEST_DIR/start-vm.sh"

echo "✅ VM setup complete!"
echo ""
echo "📋 To start testing:"
echo "1. Run: $TEST_DIR/start-vm.sh"
echo "2. Follow the instructions in UTM"
echo "3. Copy the test directory to the VM"
echo "4. Run the test script inside the VM"
echo ""
echo "Test directory: $TEST_DIR"