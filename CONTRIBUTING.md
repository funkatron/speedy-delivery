# Contributing to Speedy Delivery

Thank you for your interest in contributing to Speedy Delivery! This document provides guidelines for contributing to the project.

## Development Setup

1. **Fork and clone the repository**
   ```bash
   git clone https://github.com/yourusername/speedy-delivery.git
   cd speedy-delivery
   ```

2. **Install dependencies**
   ```bash
   # Install fswatch (required for development)
   brew install fswatch
   ```

3. **Make the script executable**
   ```bash
   chmod +x speedy-delivery
   ```

## Running Tests

Before submitting any changes, please run the test suite:

```bash
./test/test_speedy_delivery.sh
```

## Code Style Guidelines

### Bash Script Guidelines

- Use `#!/bin/bash` shebang
- Use `set -e` for error handling
- Quote all variables: `"$variable"`
- Use meaningful variable names
- Add comments for complex logic
- Follow the existing code style

### Commit Message Guidelines

Use conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat: add support for .tiff files
fix: prevent duplicate file openings
docs: update installation instructions
```

## Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the code style guidelines
   - Add tests if applicable
   - Update documentation if needed

3. **Test your changes**
   ```bash
   ./test/test_speedy_delivery.sh
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Provide a clear description of the changes
   - Include any relevant issue numbers
   - Ensure all tests pass

## Issue Reporting

When reporting issues, please include:

1. **Environment details**
   - macOS version
   - fswatch version (`fswatch --version`)
   - How you installed the tool

2. **Steps to reproduce**
   - Clear, step-by-step instructions
   - Sample files if relevant

3. **Expected vs actual behavior**
   - What you expected to happen
   - What actually happened

4. **Logs**
   - Check `~/Library/Logs/speedy-delivery.log`
   - Include relevant log entries

## Feature Requests

When suggesting new features:

1. **Describe the use case**
   - What problem does this solve?
   - How would you use this feature?

2. **Consider implementation**
   - Is this feasible with the current architecture?
   - Are there any dependencies or limitations?

3. **Check existing issues**
   - Search for similar requests
   - Add to existing discussions if relevant

## Code Review Process

All contributions require review before merging:

1. **Automated checks**
   - Tests must pass
   - No merge conflicts

2. **Manual review**
   - Code quality and style
   - Functionality and edge cases
   - Documentation updates

3. **Approval**
   - At least one maintainer approval required
   - All concerns must be addressed

## Getting Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Code Review**: For specific implementation questions

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.