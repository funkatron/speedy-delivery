# Makefile for Speedy Delivery

.PHONY: help install uninstall test clean lint

# Default target
help:
	@echo "Speedy Delivery - Available targets:"
	@echo ""
	@echo "  install    - Install speedy-delivery to /usr/local/bin"
	@echo "  uninstall  - Remove speedy-delivery from /usr/local/bin"
	@echo "  test       - Run the test suite"
	@echo "  test-clean - Run clean test in isolated environment"
	@echo "  smoke-test - Run smoke test to demonstrate functionality"
	@echo "  clean      - Clean up test files and cache"
	@echo "  lint       - Check script syntax"
	@echo "  help       - Show this help message"
	@echo ""

# Install the tool
install:
	@echo "Installing Speedy Delivery..."
	@./install.sh

# Uninstall the tool
uninstall:
	@echo "Uninstalling Speedy Delivery..."
	@./uninstall.sh

# Run tests
test:
	@echo "Running tests..."
	@./test/test_speedy_delivery.sh

# Run clean test in isolated environment
test-clean:
	@echo "Running clean test in isolated environment..."
	@./test/clean-test.sh

# Run smoke test to demonstrate functionality
smoke-test:
	@echo "Running smoke test..."
	@./test/smoke-test.sh

# Clean up test files and cache
clean:
	@echo "Cleaning up..."
	@rm -rf test/test_files
	@rm -rf ~/.cache/speedy-delivery
	@echo "Cleanup complete"

# Check script syntax
lint:
	@echo "Checking script syntax..."
	@bash -n speedy-delivery
	@bash -n install.sh
	@bash -n uninstall.sh
	@bash -n test/test_speedy_delivery.sh
	@echo "All scripts have valid syntax"

# Show version
version:
	@echo "Speedy Delivery v1.0.0"

# Show project info
info:
	@echo "Speedy Delivery - macOS File Watcher"
	@echo "===================================="
	@echo "Description: Watches folders and opens new image/PDF files in Preview"
	@echo "License: MIT"
	@echo "Requirements: macOS, fswatch"
	@echo ""
	@echo "Files:"
	@ls -la *.sh *.md Makefile 2>/dev/null || true
	@echo ""
	@echo "Test files:"
	@ls -la test/ 2>/dev/null || true