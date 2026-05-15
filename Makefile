# ============================================================
# Brookhill — Makefile
# ============================================================

.PHONY: help install hooks lint secrets run clean all-checks

# Default target — show available commands
help:
	@echo ""
	@echo "Brookhill — available commands"
	@echo ""
	@echo "  make install       Create venv and install all dependencies"
	@echo "  make hooks         Set up Git hooks and pre-commit environments"
	@echo "  make setup         install + hooks in one command"
	@echo ""
	@echo "  make lint          Run ruff linter manually"
	@echo "  make lint-fix      Run ruff linter and auto-fix issues"
	@echo "  make secrets       Update detect-secrets baseline"
	@echo "  make check-hooks   Run all pre-commit checks manually against staged files"
	@echo "  make check-all     Run all pre-commit checks against every file in the repo"
	@echo "  make all-checks    lint + secrets + check-all in one command"
	@echo ""
	@echo "  make run           Run the ingestion script locally"
	@echo "  make clean         Remove venv and cached Python files"
	@echo ""

# ============================================================
# Setup
# ============================================================

install:
	@echo "Creating virtual environment..."
	python3 -m venv venv
	@echo "Installing dependencies..."
	. venv/bin/activate && pip install -r requirements-dev.txt
	@echo ""
	@echo "Done. Activate your venv with: source venv/bin/activate"

hooks:
	@echo "Setting up Git hooks..."
	git config core.hooksPath .githooks
	. venv/bin/activate && pre-commit install-hooks
	@echo "Done."

setup: install hooks
	@echo ""
	@echo "Setup complete. Run 'source venv/bin/activate' to activate your venv."

# ============================================================
# Checks — run individually or together
# ============================================================

lint:
	@echo "Running ruff linter..."
	. venv/bin/activate && ruff check ingestion/

lint-fix:
	@echo "Running ruff linter with auto-fix..."
	. venv/bin/activate && ruff check ingestion/ --fix

secrets:
	@echo "Updating detect-secrets baseline..."
	. venv/bin/activate && python3 -m detect_secrets scan > .secrets.baseline
	@echo "Done. Commit the updated .secrets.baseline."

check-hooks:
	@echo "Running pre-commit checks against staged files..."
	. venv/bin/activate && pre-commit run

check-all:
	@echo "Running pre-commit checks against all files..."
	. venv/bin/activate && pre-commit run --all-files

all-checks: lint check-all
	@echo ""
	@echo "All checks complete."

# ============================================================
# Run
# ============================================================

run:
	@echo "Running ingestion script..."
	. venv/bin/activate && cd ingestion && python ingest.py

# ============================================================
# Clean
# ============================================================

clean:
	@echo "Removing venv and cached files..."
	rm -rf venv
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "Done."
