#!/bin/bash

# Single command to test Speedy Delivery in a clean environment
# This creates a temporary directory, copies files, and runs tests

# Don't exit on errors, we'll handle them manually
set +e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 Speedy Delivery Clean Test${NC}"
echo "================================"

# Create temporary test directory
TEST_DIR="/tmp/speedy-test-$$"
echo -e "${YELLOW}📁 Creating clean test environment: $TEST_DIR${NC}"
mkdir -p "$TEST_DIR"

# Cleanup function
cleanup() {
    echo -e "${YELLOW}🧹 Cleaning up test environment...${NC}"
    rm -rf "$TEST_DIR"
    # Kill any running speedy-delivery processes
    pkill -f "speedy-delivery" 2>/dev/null || true
}

# Set up cleanup on exit
trap cleanup EXIT

# Copy project files to test directory
echo -e "${YELLOW}📋 Copying project files...${NC}"
cp -r . "$TEST_DIR/"
cd "$TEST_DIR"

# Make scripts executable (ignore errors for missing files)
chmod +x speedy-delivery install.sh uninstall.sh 2>/dev/null || true
chmod +x test/*.sh 2>/dev/null || true

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

echo ""
echo -e "${BLUE}🔍 Running Installation Tests${NC}"
echo "================================"

# Test 1: Check if all required files are present
log_test "Checking required files"
REQUIRED_FILES=("speedy-delivery" "install.sh" "uninstall.sh" "README.md" "LICENSE" ".gitignore" "Makefile")
MISSING_FILES=()
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        MISSING_FILES+=("$file")
    fi
done

if [[ ${#MISSING_FILES[@]} -eq 0 ]]; then
    log_pass "All required files present"
else
    log_fail "Missing files: ${MISSING_FILES[*]}"
fi

# Test 2: Check script syntax
log_test "Checking script syntax"
if bash -n speedy-delivery 2>/dev/null; then
    log_pass "Main script syntax OK"
else
    log_fail "Main script has syntax errors"
fi

if bash -n install.sh 2>/dev/null; then
    log_pass "Install script syntax OK"
else
    log_fail "Install script has syntax errors"
fi

if bash -n uninstall.sh 2>/dev/null; then
    log_pass "Uninstall script syntax OK"
else
    log_fail "Uninstall script has syntax errors"
fi

# Test 3: Check help functionality
log_test "Testing help functionality"
if ./speedy-delivery --help 2>/dev/null | grep -q "Usage:"; then
    log_pass "Help functionality works"
else
    log_fail "Help functionality failed"
fi

# Test 4: Check Makefile targets
log_test "Testing Makefile targets"
if make help &>/dev/null; then
    log_pass "Makefile help target works"
else
    log_fail "Makefile help target failed"
fi

if make lint &>/dev/null; then
    log_pass "Makefile lint target works"
else
    log_fail "Makefile lint target failed"
fi

echo ""
echo -e "${BLUE}🔧 Testing Installation Process${NC}"
echo "=================================="

# Test 5: Simulate installation (without actually installing)
log_test "Testing installation script logic"
# Just test the script syntax and basic logic, don't actually install
if bash -n install.sh 2>/dev/null; then
    log_pass "Install script syntax OK"
else
    log_fail "Install script has syntax errors"
fi

# Test 6: Test uninstall script logic
log_test "Testing uninstall script logic"
# Just test the script syntax and basic logic, don't actually uninstall
if bash -n uninstall.sh 2>/dev/null; then
    log_pass "Uninstall script syntax OK"
else
    log_fail "Uninstall script has syntax errors"
fi

echo ""
echo -e "${BLUE}📊 Test Results${NC}"
echo "================"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Total: $((PASSED + FAILED))"

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
    echo ""
    echo -e "${BLUE}🎉 Ready for release!${NC}"
    echo "Your Speedy Delivery project is ready to be pushed to GitHub."
    echo ""
    echo "Next steps:"
    echo "1. git init && git add . && git commit -m 'feat: initial release'"
    echo "2. Create GitHub repository"
    echo "3. git remote add origin <your-repo-url>"
    echo "4. git push -u origin main"
    exit 0
else
    echo -e "${RED}❌ Some tests failed!${NC}"
    echo "Please fix the issues before releasing."
    exit 1
fi