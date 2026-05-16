#!/bin/bash

# ============================================================
# Brookhill — Welcome to the repo
# Interactive CLI app (Command Line Interface) — developer onboarding
# Run from the repo root: chmod +x onboarding.sh && ./onboarding.sh
# ============================================================

# ── Colours ──────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Helpers ───────────────────────────────────────────────────
section() {
  echo ""
  echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${BLUE}${BOLD}  $1${RESET}"
  echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo ""
}

info() {
  echo -e "${CYAN}ℹ  $1${RESET}"
}

success() {
  echo -e "${GREEN}✅  $1${RESET}"
}

warning() {
  echo -e "${YELLOW}⚠️  $1${RESET}"
}

error() {
  echo -e "${RED}❌  $1${RESET}"
}

pause() {
  echo ""
  echo -e "${YELLOW}${BOLD}👉  $1${RESET}"
  echo -e "${YELLOW}    Press ENTER to continue...${RESET}"
  read -r
}



confirm() {
  echo ""
  echo -e "${YELLOW}${BOLD}❓  $1 (y/n)${RESET}"
  read -r ANSWER
  if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
    error "Please fix the issue above before continuing. Re-run this script when ready."
    exit 1
  fi
}

# ── Welcome ───────────────────────────────────────────────────
clear
echo ""
echo -e "${BOLD}  Welcome to Brookhill, Jon.${RESET}"
echo ""
echo -e "  ${CYAN}Brookhill Developer Onboarding — CLI App (Command Line Interface)${RESET}"
echo ""
echo "  This CLI app guides you through the repo setup and conventions."
echo "  It covers cloning, Python, virtual environments, Git hooks,"
echo "  branch naming, commit messages, credential protection, and linting."
echo ""
echo "  Work through each step — if you reach the end you will"
echo "  receive a completion code. Share that code with the Project"
echo "  Lead as confirmation you are set up."
echo ""
echo "  Estimated time: 20-30 minutes"
echo ""
echo "  You can exit at any time with Ctrl+C."
echo "  The script always starts from the beginning when re-run — but any"
echo "  steps where your setup is correct will pass automatically and quickly,"
echo "  so getting back to where you were takes seconds not minutes."
echo ""
pause "Ready to start?"

# ============================================================
# STEP 0 — Clone the repo
# ============================================================
section "Step 0 of 8 — Clone the repo"

info "First, let's confirm Git is installed on your machine."
echo ""

GIT_VERSION=$(git --version 2>/dev/null)
if [[ $? -eq 0 ]]; then
  success "Git is installed. You have: ${GIT_VERSION}"
  info "Continuing automatically..."
else
  error "Git is not installed."
  echo "  Download it from: https://git-scm.com/downloads"
  echo "  Then re-run this script."
  exit 1
fi

echo ""
info "If you have not cloned the repo yet, open a new terminal tab and run:"
echo ""
echo -e "  ${CYAN}git clone https://github.com/lesleyashley-ng/Brookhill.git${RESET}"
echo -e "  ${CYAN}cd Brookhill${RESET}"
echo -e "  ${CYAN}chmod +x onboarding.sh${RESET}"
echo -e "  ${CYAN}./onboarding.sh${RESET}"
echo ""
info "If you are already inside the repo, we will continue."
echo ""

if [ ! -d ".git" ]; then
  error "You are not inside the Brookhill repo."
  echo "  Clone it first using the commands above, then re-run this script."
  exit 1
fi

success "You are inside the Brookhill repo."
echo ""
info "Switching to the develop branch and pulling the latest changes..."
echo ""
echo -e "  ${CYAN}git checkout develop${RESET}"
echo -e "  ${CYAN}git pull origin develop${RESET}"
echo ""
git checkout develop 2>&1 && git pull origin develop 2>&1

CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
success "You are now on branch: ${CURRENT_BRANCH}"


# ============================================================
# STEP 1 — pyenv, Python and venv
# ============================================================
section "Step 1 of 8 — pyenv, Python version and virtual environment"

REQUIRED_VERSION="3.11.9"

# ── 1a. Check Homebrew ───────────────────────────────────────
info "Checking Homebrew is installed (required to install pyenv)..."
echo ""

if command -v brew &> /dev/null; then
  BREW_VERSION=$(brew --version | head -1)
  success "Homebrew is installed. You have: ${BREW_VERSION}"
  info "Continuing automatically..."
else
  error "Homebrew is not installed."
  echo ""
  echo "  Homebrew is required to install pyenv. Install it with:"
  echo ""
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  echo ""
  echo "  Then re-run this script."
  exit 1
fi

echo ""

# ── 1b. Check pyenv ──────────────────────────────────────────
info "Checking pyenv is installed..."
echo ""

if command -v pyenv &> /dev/null; then
  PYENV_VERSION=$(pyenv --version)
  success "pyenv is installed. You have: ${PYENV_VERSION}"
  info "Continuing automatically..."
else
  error "pyenv is not installed."
  echo ""
  echo "  pyenv manages Python versions per project. Install it with:"
  echo ""
  echo -e "  ${CYAN}brew install pyenv${RESET}"
  echo -e "  ${CYAN}echo 'export PYENV_ROOT="\$HOME/.pyenv"' >> ~/.zshrc${RESET}"
  echo -e "  ${CYAN}echo 'export PATH="\$PYENV_ROOT/bin:\$PATH"' >> ~/.zshrc${RESET}"
  echo '  echo eval "$(pyenv init -)" >> ~/.zshrc'
  echo -e "  ${CYAN}source ~/.zshrc${RESET}"
  echo ""
  echo "  Then re-run this script."
  exit 1
fi

echo ""

# ── 1c. Check Python 3.11.9 is installed via pyenv ───────────
info "Checking Python ${REQUIRED_VERSION} is installed via pyenv..."
echo ""

if pyenv versions | grep -q "$REQUIRED_VERSION"; then
  success "Python ${REQUIRED_VERSION} is available in pyenv."
  info "Continuing automatically..."
else
  error "Python ${REQUIRED_VERSION} is not installed in pyenv."
  echo ""
  echo "  Install it with:"
  echo ""
  echo -e "  ${CYAN}pyenv install ${REQUIRED_VERSION}${RESET}"
  echo ""
  echo "  This may take a few minutes. Then re-run this script."
  exit 1
fi

echo ""

# ── 1d. Check .python-version is respected ───────────────────
info "Checking the repo .python-version pin is active..."
echo ""

ACTIVE_VERSION=$(python3 --version 2>/dev/null | awk '{print $2}')

if [[ "$ACTIVE_VERSION" == "$REQUIRED_VERSION" ]]; then
  success "Active Python version is ${ACTIVE_VERSION} — matches the repo pin. Continuing automatically..."
else
  error "Active Python version is ${ACTIVE_VERSION} — expected ${REQUIRED_VERSION}."
  echo ""
  echo "  The .python-version file pins this repo to ${REQUIRED_VERSION}."
  echo "  Make sure pyenv is initialised in your shell and run:"
  echo ""
  echo -e "  ${CYAN}pyenv local ${REQUIRED_VERSION}${RESET}"
  echo -e "  ${CYAN}python3 --version${RESET}"
  echo ""
  echo "  Then re-run this script."
  exit 1
fi

echo ""

# ── 1e. Check venv is active ─────────────────────────────────
info "Checking your virtual environment is active..."
echo ""

if [[ "$VIRTUAL_ENV" != "" ]]; then
  success "Virtual environment is active at: ${VIRTUAL_ENV}"
  info "Continuing automatically..."
else
  error "No virtual environment is active."
  echo ""
  echo "  Create and activate one with:"
  echo ""
  echo -e "  ${CYAN}python3 -m venv venv${RESET}"
  echo -e "  ${CYAN}source venv/bin/activate${RESET}"
  echo ""
  echo "  pyenv will ensure the venv uses Python ${REQUIRED_VERSION} automatically."
  echo "  Then re-run this script."
  exit 1
fi

echo ""

# ── 1f. Check pip ────────────────────────────────────────────
info "Checking pip is available..."
echo ""

PIP_VERSION=$(pip --version 2>/dev/null)
if [[ $? -eq 0 ]]; then
  success "pip is available. You have: ${PIP_VERSION}"
  info "Continuing automatically..."
else
  error "pip is not available. Make sure your venv is active and run: pip install -r requirements-dev.txt"
  exit 1
fi


# ============================================================
# STEP 2 — Repo structure
# ============================================================
section "Step 2 of 8 — Repo structure"

info "Here is what the Brookhill repo looks like and what each part does."
echo ""
echo -e "  ${CYAN}ingestion/${RESET}          Python ETL pipeline"
echo -e "    ├── extract.py      Fetches data from the Plinth API"
echo -e "    ├── transform.py    Validates and cleans the data"
echo -e "    ├── load.py         Inserts data into Supabase"
echo -e "    ├── ingest.py       Main entry point — runs extract → transform → load"
echo -e "    └── __init__.py     Makes ingestion a Python package"
echo ""
echo -e "  ${CYAN}migration/${RESET}          One-off script to pull all historical Plinth data into Supabase"
echo -e "  ${CYAN}schema/${RESET}             Supabase database schema — placeholder until API spike is done"
echo -e "  ${CYAN}queries/${RESET}            Pre-built SQL queries used by Google Data Studio"
echo -e "  ${CYAN}docs/${RESET}               Project documentation"
echo -e "    └── data-protection.md  GDPR and data retention policy"
echo ""
echo -e "  ${CYAN}.githooks/${RESET}          Git hooks — run automatically to enforce project conventions"
echo -e "  ${CYAN}.github/workflows/${RESET}  GitHub Actions — protect-main.yml blocks PRs into main from non-develop branches"
echo -e "  ${CYAN}.pre-commit-config.yaml${RESET}  Defines all pre-commit checks (ruff, secrets, whitespace etc)"
echo -e "  ${CYAN}.python-version${RESET}     Pins this repo to Python 3.11.9 — pyenv reads this automatically"
echo -e "  ${CYAN}.secrets.baseline${RESET}   detect-secrets reference file — do not delete"
echo -e "  ${CYAN}Makefile${RESET}            Shortcuts for common tasks — run make help to see all"
echo -e "  ${CYAN}onboarding.sh${RESET}       This script"
echo -e "  ${CYAN}requirements.txt${RESET}    Production dependencies"
echo -e "  ${CYAN}requirements-dev.txt${RESET} Development dependencies (includes requirements.txt)"
echo ""
info "Current repo file tree:"
echo ""
if command -v tree &> /dev/null; then
  tree -a -I 'venv|__pycache__|.git|.ruff_cache|*.pyc'
else
  find . -not -path './venv/*' -not -path './.git/*' -not -path './__pycache__/*' -not -path './.ruff_cache/*' | sort | sed 's|[^/]*/|  |g'
fi


# ============================================================
# STEP 3 — Git hooks
# ============================================================
section "Step 3 of 8 — Git hooks"

info "Brookhill uses Git hooks to catch problems before they reach a PR."
info "Checking your hooks are installed correctly..."
echo ""

HOOKS_PATH=$(git config core.hooksPath)
if [[ "$HOOKS_PATH" == ".githooks" ]]; then
  success "Git hooks path is set correctly to: .githooks"
  info "Continuing automatically..."
  echo ""
  info "The following hooks are active:"
  echo -e "  ${CYAN}pre-commit${RESET}   Runs on every commit — checks branch name, blocks .env, runs linting"
  echo -e "  ${CYAN}commit-msg${RESET}   Runs after you write a commit message — enforces Conventional Commits format"
  echo -e "  ${CYAN}pre-push${RESET}     Runs before you push — checks branch is based on develop"
  echo ""
  warning "Some hooks modify your files automatically — for example:"
  echo "  - ruff fixes Python formatting and removes unused imports"
  echo "  - the end-of-file fixer adds a missing newline at the end of a file"
  echo "  - the trailing whitespace fixer removes spaces at the end of lines"
  echo ""
  echo "  When a hook modifies a file, Git unstages it because the content changed."
  echo "  Your commit will be blocked. This is not an error — just re-stage and retry:"
  echo ""
  echo -e "  ${CYAN}git add .${RESET}                   re-stage everything the hooks fixed"
  echo -e "  ${CYAN}git commit -m "your message"${RESET}  now it goes through"
  echo ""
  info "Tip: run 'make lint-fix' before staging to let ruff fix everything first."
else
  error "Git hooks are not set up. Your hooks path is: '${HOOKS_PATH}'"
  echo ""
  echo "  Run: make hooks"
  echo "  Then re-run this script."
  exit 1
fi


# ============================================================
# STEP 4 — Branch naming
# ============================================================
section "Step 4 of 8 — Branch naming convention"

info "Every branch must follow this format: type/description"
echo ""
echo -e "  Valid types: ${CYAN}feature/, fix/, chore/, docs/, refactor/, test/, ci/${RESET}"
echo ""
echo -e "  Examples:"
echo -e "  ${GREEN}✅  feature/plinth-ingestion-script${RESET}"
echo -e "  ${GREEN}✅  fix/pagination-offset-bug${RESET}"
echo -e "  ${GREEN}✅  chore/update-requirements${RESET}"
echo -e "  ${RED}❌  my-branch${RESET}"
echo -e "  ${RED}❌  jonathan-work${RESET}"
echo -e "  ${RED}❌  updates${RESET}"
echo ""

# Happy path
info "HAPPY PATH — creating a correctly named branch"
echo ""
echo -e "  Running: ${CYAN}git checkout -b feature/onboarding-test${RESET}"
echo ""
git checkout -b feature/onboarding-test 2>/dev/null || git checkout feature/onboarding-test 2>/dev/null
success "Branch 'feature/onboarding-test' created. This name is valid — the hook will allow commits."


# Unhappy path
echo ""
info "UNHAPPY PATH — trying to commit on a badly named branch"
echo ""
echo -e "  Running: ${CYAN}git checkout -b bad-branch-name${RESET}"
echo ""
git checkout -b bad-branch-name 2>/dev/null || git checkout bad-branch-name 2>/dev/null
echo ""
echo -e "  Running: ${CYAN}git commit --allow-empty -m 'chore: test bad branch name'${RESET}"
echo ""
git commit --allow-empty -m "chore: test bad branch name" 2>&1 || true
echo ""
error "The hook blocked this commit because 'bad-branch-name' does not follow the naming convention."
info "Valid types are: feature/, fix/, chore/, docs/, refactor/, test/, ci/"


# Return to test branch
git checkout feature/onboarding-test 2>/dev/null
git branch -D bad-branch-name 2>/dev/null
pause "Understood — always create branches using:\n  'git checkout develop'\n  'git pull origin develop'\n  'git checkout -b feature/your-task-name'"

# ============================================================
# STEP 5 — Commit messages
# ============================================================
section "Step 5 of 8 — Conventional Commits"

info "All commit messages must follow this format: type: short description"
echo ""
echo -e "  Valid types: ${CYAN}feat, fix, chore, docs, refactor, test, ci${RESET}"
echo ""
echo -e "  Examples:"
echo -e "  ${GREEN}✅  feat: add Plinth member ingestion script${RESET}"
echo -e "  ${GREEN}✅  fix: handle pagination for bookings over 250 records${RESET}"
echo -e "  ${GREEN}✅  chore: update requirements file${RESET}"
echo -e "  ${RED}❌  updated some stuff${RESET}"
echo -e "  ${RED}❌  WIP${RESET}"
echo -e "  ${RED}❌  fix${RESET}"
echo ""

# Unhappy path
info "UNHAPPY PATH — a message that does not follow the convention"
echo ""
echo -e "  Running: ${CYAN}git commit --allow-empty -m 'updated some stuff'${RESET}"
echo ""
git commit --allow-empty -m "updated some stuff" 2>&1 || true
echo ""
error "The commit-msg hook rejected this message — it does not follow the Conventional Commits format."


echo ""
pause "Now let's see the happy path."

# Happy path
info "HAPPY PATH — a correctly formatted commit message"
echo ""
echo -e "  Running: ${CYAN}git commit --allow-empty -m 'chore: onboarding walkthrough test'${RESET}"
echo ""
git commit --allow-empty -m "chore: onboarding walkthrough test"
echo ""
success "Commit accepted. The message follows the Conventional Commits format."


# ============================================================
# STEP 6 — .env protection
# ============================================================
section "Step 6 of 8 — Credentials protection"

info "This project connects to external services — Plinth, Supabase, and others."
info "Each service requires an API key or password to authenticate."
echo ""
echo "  These credentials are sensitive. If they were exposed publicly:"
echo -e "  ${RED}  - Anyone could read or delete WSUP client data in Supabase${RESET}"
echo -e "  ${RED}  - Anyone could query the Plinth API as if they were WSUP${RESET}"
echo -e "  ${RED}  - Rotating compromised keys takes time and causes downtime${RESET}"
echo ""
info "This is why credentials are never stored in code or committed to Git."
echo ""
echo "  The three places credentials live in this project:"
echo ""
echo -e "  ${CYAN}.env${RESET}              Your local machine only. Gitignored. Never committed."
echo -e "  ${CYAN}GitHub Secrets${RESET}    Used by GitHub Actions in the pipeline. Never in code."
echo -e "  ${CYAN}Bitwarden${RESET}         Shared vault. How the team shares credentials securely."
echo ""
echo "  The workflow when you clone the repo:"
echo ""
echo -e "  ${CYAN}cp .env.example .env${RESET}    Creates a local .env from the template"
echo -e "  ${CYAN}open .env${RESET}               Fill in real values from Bitwarden"
echo -e "  ${CYAN}never git add .env${RESET}      It stays on your machine only"
echo ""
pause "Understood? Now let us prove the protection works."

echo ""
info "The pre-commit hook blocks .env from being committed automatically."
info "Watch what happens when we try."
echo ""

echo "PLINTH_API_KEY=YOUR_KEY_HERE" > .env

echo -e "  Running: ${CYAN}git add .env${RESET}"
echo -e "  Running: ${CYAN}git commit -m 'chore: accidentally commit credentials'${RESET}"
echo ""
git add .env 2>/dev/null || true
git commit -m "chore: accidentally commit credentials" 2>&1 || true
echo ""
error "Blocked. The .env file was never committed — the hook stopped it."
echo ""
info "If you ever accidentally stage .env, unstage it immediately with:"
echo -e "  ${CYAN}git reset HEAD .env${RESET}"
echo ""
warning "Never hardcode credentials directly in Python files either."
echo "  This is wrong:"
echo -e "  ${RED}  api_key = \"YOUR_KEY_HERE\"${RESET}"
echo ""
echo "  This is correct:"
echo -e "  ${GREEN}  api_key = os.getenv("PLINTH_API_KEY")${RESET}"
echo ""

git reset HEAD .env 2>/dev/null || true
rm -f .env

pause "Credentials are safe as long as you follow these rules."

# ============================================================
# STEP 7 — Linting
# ============================================================
section "Step 7 of 8 — Python linting with ruff"

info "Ruff is a Python linter. It checks your code for errors, bad style,"
info "and unused imports — and auto-fixes most issues."
info "It runs automatically on every commit. You can also run it manually."
echo ""

# Happy path
info "HAPPY PATH — running ruff against clean code"
echo ""
echo -e "  Running: ${CYAN}make lint${RESET}"
echo ""
make lint 2>&1 || true
echo ""
success "No issues found. Clean code passes silently."

echo ""
warning "Important — when ruff auto-fixes your code, you need to re-stage the files."
echo ""
echo "  This catches beginners out. Here is what happens:"
echo ""
echo "  1. You run: git add ingestion/extract.py"
echo "  2. You run: git commit -m "feat: add extract function""
echo "  3. Ruff runs automatically and fixes a formatting issue in extract.py"
echo "  4. Your commit is blocked — the file changed after you staged it"
echo "  5. You need to stage it again:"
echo ""
echo -e "  ${CYAN}git add ingestion/extract.py${RESET}   stage the fixed version"
echo -e "  ${CYAN}git commit -m "feat: add extract function"${RESET}   now it goes through"
echo ""
echo "  Or stage everything at once:"
echo -e "  ${CYAN}git add .${RESET}"
echo -e "  ${CYAN}git commit -m "feat: add extract function"${RESET}"
echo ""
info "Run 'make lint-fix' before committing to let ruff fix everything first, then stage."


# Unhappy path
echo ""
info "UNHAPPY PATH — ruff finding issues in badly written code"
echo ""
info "This is an example of code with unused imports and bad formatting:"
echo ""
echo -e "  ${RED}import os${RESET}          ← unused import"
echo -e "  ${RED}import sys${RESET}         ← unused import"
echo -e "  ${RED}def fetch( ):${RESET}      ← extra space inside brackets"
echo -e "  ${RED}    x=1${RESET}            ← missing spaces around operator"
echo ""

cat > /tmp/bad_example.py << 'EOF'
import os
import sys
import requests

def fetch( ):
    x=1
    y=2
    return x+y
EOF

echo -e "  Running: ${CYAN}ruff check /tmp/bad_example.py${RESET}"
echo ""
. venv/bin/activate && ruff check /tmp/bad_example.py 2>&1 || true
echo ""
info "Ruff shows you the exact file, line number, and rule that was violated."
info "Most issues are fixed automatically — run 'make lint-fix' to apply fixes."
rm -f /tmp/bad_example.py


pause "Every commit runs ruff automatically — fix issues before committing or make lint-fix handles it."

# ============================================================
# STEP 8 — Make commands
# ============================================================
section "Step 8 of 8 — Makefile commands"

info "The Makefile gives you simple shortcuts for common tasks."
info "You do not need to remember long commands — just use make."
echo ""
echo -e "  ${CYAN}make setup${RESET}       Install everything and set up hooks in one go"
echo -e "  ${CYAN}make install${RESET}     Install dependencies only"
echo -e "  ${CYAN}make hooks${RESET}       Set up Git hooks only"
echo -e "  ${CYAN}make lint${RESET}        Run ruff linter"
echo -e "  ${CYAN}make lint-fix${RESET}    Run ruff and auto-fix issues"
echo -e "  ${CYAN}make check-all${RESET}   Run all pre-commit checks against every file"
echo -e "  ${CYAN}make all-checks${RESET}  Run lint and all checks together"
echo -e "  ${CYAN}make run${RESET}         Run the ingestion script locally"
echo -e "  ${CYAN}make secrets${RESET}     Update the detect-secrets baseline"
echo -e "  ${CYAN}make clean${RESET}       Remove venv and cached files"
echo ""
echo -e "  Running: ${CYAN}make help${RESET}"
echo ""
make help 2>&1 || true


# ============================================================
# Cleanup
# ============================================================
section "Cleaning up"

info "Removing the onboarding test branch and returning to develop..."
git checkout develop 2>/dev/null || true
git branch -D feature/onboarding-test 2>/dev/null || true
success "Cleanup complete. You are back on develop."

# ============================================================
# Done
# ============================================================
echo ""
# Generate completion code from username + date + repo
COMPLETION_CODE="BROOKHILL-$(git config user.name 2>/dev/null | tr ' ' '-' | tr '[:lower:]' '[:upper:]')-$(date +%d%m%Y)"

echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}${BOLD}  Onboarding complete!${RESET}"
echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "${BOLD}  Your completion code:${RESET}"
echo ""
echo -e "  ${GREEN}${BOLD}  ${COMPLETION_CODE}  ${RESET}"
echo ""
echo "  Share this code with the Project Lead."
echo "  It confirms you ran the full onboarding on your machine."
echo ""
echo "  You have seen:"
echo -e "  ${GREEN}✅${RESET}  Step 0  Cloning the repo and checking out develop"
echo -e "  ${GREEN}✅${RESET}  Step 1  Python version confirmed and venv active"
echo -e "  ${GREEN}✅${RESET}  Step 2  Repo structure and what each folder does"
echo -e "  ${GREEN}✅${RESET}  Step 3  Git hooks installed and active"
echo -e "  ${GREEN}✅${RESET}  Step 4  Branch naming — happy and unhappy path"
echo -e "  ${GREEN}✅${RESET}  Step 5  Conventional Commits — happy and unhappy path"
echo -e "  ${GREEN}✅${RESET}  Step 6  Credentials protection — .env blocked"
echo -e "  ${GREEN}✅${RESET}  Step 7  Ruff linting — happy and unhappy path"
echo -e "  ${GREEN}✅${RESET}  Step 8  Makefile commands"
echo ""
echo "  Virtual environment reminder:"
echo -e "  Run ${CYAN}source venv/bin/activate${RESET} at the start of every working session."
echo -e "  Run ${CYAN}deactivate${RESET} when you are done to exit the venv."
echo "  If commands behave unexpectedly in a new terminal, the venv is probably not active."
echo ""
echo "  Next steps:"
echo "  1. Share your completion code with the Project Lead"
echo "  2. Read CONTRIBUTING.md for the full reference guide"
echo "  3. Pick up your first ticket"
echo ""
