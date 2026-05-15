#!/bin/bash

# setup-hooks.sh
# Run this once after cloning the repo to install Git hooks locally
# Usage: chmod +x setup-hooks.sh && ./setup-hooks.sh

set -e

echo "Installing Brookhill Git hooks..."

# Install pre-commit tool if not already installed
if ! command -v pre-commit &> /dev/null; then
  echo "Installing pre-commit..."
  pip3 install pre-commit --break-system-packages 2>/dev/null || pip3 install pre-commit
fi

# Point Git to our custom hooks directory
git config core.hooksPath .githooks

# Install pre-commit hooks from config
pre-commit install --hook-type commit-msg

echo ""
echo "Done. The following hooks are now active:"
echo "  pre-commit  — ruff linting, trailing whitespace, secret detection, branch name check, .env guard"
echo "  commit-msg  — enforces Conventional Commits format"
echo "  pre-push    — checks branch is based on develop, blocks direct push to main"
