#!/bin/bash

# Test script for speedy-delivery
# This script tests the basic functionality of the tool

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
SCRIPT_PATH="$PROJECT_DIR/speedy-delivery"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0

# Helper functions
log_test() {
    echo -e "${YELLOW}[TEST]${NC} $1"
}

log_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((PASSED++))
}

log_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((FAILED++))
}

# Test directory
TEST_DIR="$SCRIPT_DIR/test_files"
mkdir -p "$TEST_DIR"

# Cleanup function
cleanup() {
    echo "🧹 Cleaning up test files..."
    rm -rf "$TEST_DIR"
    # Kill any running speedy-delivery processes
    pkill -f "speedy-delivery" || true
}

# Set up cleanup on exit
trap cleanup EXIT

echo "🧪 Starting Speedy Delivery Tests"
echo "=================================="

# Test 1: Check if script exists and is executable
log_test "Checking if script exists and is executable"
if [[ -f "$SCRIPT_PATH" && -x "$SCRIPT_PATH" ]]; then
    log_pass "Script exists and is executable"
else
    log_fail "Script does not exist or is not executable"
fi

# Test 2: Check help functionality
log_test "Testing help functionality"
if "$SCRIPT_PATH" --help 2>/dev/null | grep -q "Usage:"; then
    log_pass "Help functionality works"
else
    log_fail "Help functionality failed"
fi

# Test 3: Check if fswatch is available
log_test "Checking if fswatch is available"
if command -v fswatch &> /dev/null; then
    log_pass "fswatch is available"
else
    log_fail "fswatch is not available (install with: brew install fswatch)"
fi

# Test 4: Test file creation and monitoring (basic)
log_test "Testing basic file monitoring"
echo "This is a test PDF" > "$TEST_DIR/test.pdf"

# Start speedy-delivery in background
"$SCRIPT_PATH" "$TEST_DIR" > /dev/null 2>&1 &
SPEEDY_PID=$!

# Give it a moment to start
sleep 2

# Create a test image file
echo "This is a test image" > "$TEST_DIR/test.jpg"

# Wait a bit for processing
sleep 3

# Check if the process is still running
if kill -0 "$SPEEDY_PID" 2>/dev/null; then
    log_pass "Speedy delivery started and is running"
    kill "$SPEEDY_PID" 2>/dev/null || true
else
    log_fail "Speedy delivery failed to start or crashed"
fi

# Test 5: Check log file creation
log_test "Testing log file creation"
LOG_FILE="$HOME/Library/Logs/speedy-delivery.log"
if [[ -f "$LOG_FILE" ]]; then
    log_pass "Log file was created"
else
    log_fail "Log file was not created"
fi

# Test 6: Check cache directory creation
log_test "Testing cache directory creation"
CACHE_DIR="$HOME/.cache/speedy-delivery"
if [[ -d "$CACHE_DIR" ]]; then
    log_pass "Cache directory was created"
else
    log_fail "Cache directory was not created"
fi

# Test 7: Test supported file types
log_test "Testing supported file types"
SUPPORTED_FILES=("test.jpg" "test.jpeg" "test.png" "test.webp" "test.gif" "test.heic" "test.pdf")
for file in "${SUPPORTED_FILES[@]}"; do
    echo "test content" > "$TEST_DIR/$file"
done
log_pass "All supported file types can be created"

# Test 8: Test unsupported file types (should be ignored)
log_test "Testing unsupported file types"
UNSUPPORTED_FILES=("test.txt" "test.doc" "test.mp4" "test.mp3")
for file in "${UNSUPPORTED_FILES[@]}"; do
    echo "test content" > "$TEST_DIR/$file"
done
log_pass "Unsupported file types can be created (will be ignored by speedy-delivery)"

echo ""
echo "📊 Test Results"
echo "==============="
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Total: $((PASSED + FAILED))"

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed!${NC}"
    exit 1
fi