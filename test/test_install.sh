#!/bin/bash

# Test script to verify installation process
# This simulates a clean installation without affecting the current environment

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 Testing Speedy Delivery Installation${NC}"
echo "=============================================="

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

# Test 1: Check if install script exists and is executable
log_test "Checking install script"
if [[ -f "$PROJECT_DIR/install.sh" && -x "$PROJECT_DIR/install.sh" ]]; then
    log_pass "Install script exists and is executable"
else
    log_fail "Install script missing or not executable"
fi

# Test 2: Check if uninstall script exists and is executable
log_test "Checking uninstall script"
if [[ -f "$PROJECT_DIR/uninstall.sh" && -x "$PROJECT_DIR/uninstall.sh" ]]; then
    log_pass "Uninstall script exists and is executable"
else
    log_fail "Uninstall script missing or not executable"
fi

# Test 3: Check if main script exists and is executable
log_test "Checking main script"
if [[ -f "$PROJECT_DIR/speedy-delivery" && -x "$PROJECT_DIR/speedy-delivery" ]]; then
    log_pass "Main script exists and is executable"
else
    log_fail "Main script missing or not executable"
fi

# Test 4: Check if fswatch is available
log_test "Checking fswatch availability"
if command -v fswatch &> /dev/null; then
    log_pass "fswatch is available"
else
    log_fail "fswatch is not available (install with: brew install fswatch)"
fi

# Test 5: Check if we can create necessary directories
log_test "Testing directory creation permissions"
TEMP_DIR="/tmp/speedy-test-$$"
mkdir -p "$TEMP_DIR"
if [[ -d "$TEMP_DIR" ]]; then
    log_pass "Can create directories"
    rm -rf "$TEMP_DIR"
else
    log_fail "Cannot create directories"
fi

# Test 6: Check if we can write to /usr/local/bin (simulated)
log_test "Testing /usr/local/bin write permissions"
if [[ -w "/usr/local/bin" ]] || [[ "$(id -u)" -eq 0 ]]; then
    log_pass "Can write to /usr/local/bin or have sudo access"
else
    log_fail "Cannot write to /usr/local/bin and no sudo access"
fi

# Test 7: Check if all required files are present
log_test "Checking all required project files"
REQUIRED_FILES=(
    "speedy-delivery"
    "install.sh"
    "uninstall.sh"
    "README.md"
    "LICENSE"
    ".gitignore"
    "Makefile"
    "CHANGELOG.md"
    "CONTRIBUTING.md"
    "test/test_speedy_delivery.sh"
)

MISSING_FILES=()
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$PROJECT_DIR/$file" ]]; then
        MISSING_FILES+=("$file")
    fi
done

if [[ ${#MISSING_FILES[@]} -eq 0 ]]; then
    log_pass "All required files are present"
else
    log_fail "Missing files: ${MISSING_FILES[*]}"
fi

# Test 8: Check script syntax
log_test "Checking script syntax"
if bash -n "$PROJECT_DIR/speedy-delivery" 2>/dev/null; then
    log_pass "Main script has valid syntax"
else
    log_fail "Main script has syntax errors"
fi

if bash -n "$PROJECT_DIR/install.sh" 2>/dev/null; then
    log_pass "Install script has valid syntax"
else
    log_fail "Install script has syntax errors"
fi

if bash -n "$PROJECT_DIR/uninstall.sh" 2>/dev/null; then
    log_pass "Uninstall script has valid syntax"
else
    log_fail "Uninstall script has syntax errors"
fi

# Test 9: Check if help works
log_test "Testing help functionality"
if "$PROJECT_DIR/speedy-delivery" --help 2>/dev/null | grep -q "Usage:"; then
    log_pass "Help functionality works"
else
    log_fail "Help functionality failed"
fi

# Test 10: Check if Makefile targets work
log_test "Testing Makefile targets"
if make -f "$PROJECT_DIR/Makefile" help &>/dev/null; then
    log_pass "Makefile help target works"
else
    log_fail "Makefile help target failed"
fi

if make -f "$PROJECT_DIR/Makefile" lint &>/dev/null; then
    log_pass "Makefile lint target works"
else
    log_fail "Makefile lint target failed"
fi

echo ""
echo -e "${BLUE}📊 Installation Test Results${NC}"
echo "================================"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Total: $((PASSED + FAILED))"

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✅ All installation tests passed!${NC}"
    echo ""
    echo -e "${BLUE}Next steps for testing actual installation:${NC}"
    echo "1. Create a fresh directory: mkdir ~/test-speedy && cd ~/test-speedy"
    echo "2. Clone the repo: git clone <your-repo-url> ."
    echo "3. Run installation: ./install.sh"
    echo "4. Test the tool: speedy-delivery --help"
    echo "5. Clean up: ./uninstall.sh"
    exit 0
else
    echo -e "${RED}❌ Some installation tests failed!${NC}"
    echo "Please fix the issues before releasing."
    exit 1
fi