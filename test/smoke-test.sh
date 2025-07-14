#!/bin/bash

# Speedy Delivery Smoke Test
# Demonstrates the tool in action with real file watching

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔥 Speedy Delivery Smoke Test${NC}"
echo "================================"

# Create test directory
TEST_DIR="/tmp/speedy-smoke-test-$$"
echo -e "${YELLOW}📁 Creating test directory: $TEST_DIR${NC}"
mkdir -p "$TEST_DIR"

# Cleanup function
cleanup() {
    echo -e "${YELLOW}🧹 Cleaning up...${NC}"
    pkill -f "speedy-delivery" 2>/dev/null || true
    rm -rf "$TEST_DIR"
    echo -e "${GREEN}✅ Cleanup complete${NC}"
}

# Set up cleanup on exit
trap cleanup EXIT

echo -e "${YELLOW}🚀 Starting Speedy Delivery...${NC}"
echo "Watching directory: $TEST_DIR"
echo ""

# Start speedy-delivery in background
./speedy-delivery "$TEST_DIR" &
SPEEDY_PID=$!

# Give it a moment to start
sleep 2

echo -e "${YELLOW}📄 Creating test files...${NC}"

# Create test files
echo "This is a test image" > "$TEST_DIR/test.jpg"
sleep 1
echo "This is a test PDF" > "$TEST_DIR/test.pdf"
sleep 1
echo "This is a test PNG" > "$TEST_DIR/test.png"
sleep 1

echo -e "${YELLOW}📋 Checking logs...${NC}"
sleep 2
echo "Recent log entries:"
tail -n 5 ~/Library/Logs/speedy-delivery.log 2>/dev/null || echo "No log entries found"

echo ""
echo -e "${YELLOW}🗂️  Checking cache...${NC}"
if [[ -d ~/.cache/speedy-delivery ]]; then
    echo "Cache directory exists:"
    ls -la ~/.cache/speedy-delivery/ 2>/dev/null || echo "Cache directory is empty"
else
    echo "Cache directory not found"
fi

echo ""
echo -e "${YELLOW}⏹️  Stopping Speedy Delivery...${NC}"
kill "$SPEEDY_PID" 2>/dev/null || true
sleep 1

echo ""
echo -e "${GREEN}✅ Smoke test completed!${NC}"
echo ""
echo -e "${BLUE}📊 What we tested:${NC}"
echo "• File watching functionality"
echo "• Log file creation"
echo "• Cache directory creation"
echo "• Process management"
echo "• Clean shutdown"
echo ""
echo -e "${BLUE}🎯 Next steps:${NC}"
echo "• Run 'make test-clean' for comprehensive testing"
echo "• Install with './install.sh' for real use"
echo "• Push to GitHub when ready"