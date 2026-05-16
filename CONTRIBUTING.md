# Contributing to Brookhill

Thanks for contributing. Please read this before starting any work.

New contributors must sign a **Contributor Agreement** before committing any code. See `docs/contributor-agreement.docx` and contact the Project Lead to get set up.

---

## Prerequisites

Before cloning the repo, make sure your Mac is set up correctly.

### Python 3.11.9

Check your Python version:

```bash
python3 --version
```

If it's not 3.11.9, install it via [python.org](https://www.python.org/downloads/) or pyenv.

### Fix pip and python commands

Macs don't alias `pip` or `python` to their Python 3 versions by default. Add these aliases to your `~/.zshrc` so they work without the `3` suffix:

```bash
echo 'alias pip=pip3' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
source ~/.zshrc
```

You only need to do this once. After this `pip` and `python` will work as expected throughout the project.

### Git

Check Git is installed:

```bash
git --version
```

If not installed: https://git-scm.com/downloads

### VS Code

Download from https://code.visualstudio.com if not already installed.

---

## Setting up your environment

### 1. Clone the repo and create a virtual environment

```bash
git clone https://github.com/[org]/brookhill.git
cd brookhill
python3 -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
```

The `venv/` folder is gitignored — never commit it. Run `source venv/bin/activate` at the start of every working session to activate it.

To deactivate the venv when you're done working:
```bash
deactivate
```

### 2. Set up environment variables

```bash
cp .env.example .env
```

Fill in the values from Bitwarden. Contact the Project Lead for access.

### 3. Install Git hooks — run once after cloning

```bash
git config core.hooksPath .githooks
pre-commit install-hooks
```

---

## Branching strategy

| Branch | Purpose |
|---|---|
| `main` | Production — stable, deployable. PR from `develop` only. |
| `develop` | Integration — all feature branches merge here first. |
| `feature/*` | Individual pieces of work, always branched from `develop` |

No direct pushes to `main` or `develop`. All changes go through a pull request.

### Starting a new piece of work

Always branch from the latest `develop`:

```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-task-name
```

---

## Conventional Commits

All commit messages and PR titles must follow the Conventional Commits format:

```
type: short description
```

| Type | When to use |
|---|---|
| `feat` | A new feature |
| `fix` | A bug fix |
| `chore` | Housekeeping — setup, config, tooling, no production code change |
| `docs` | Documentation only |
| `refactor` | Code restructured but behaviour unchanged |
| `test` | Adding or updating tests |
| `ci` | Changes to GitHub Actions or CI configuration |

**Examples**

```
feat: add Plinth member ingestion script
fix: handle pagination for bookings over 250 records
chore: add python version pin and requirements
docs: update data protection policy
refactor: split ingestion logic into ETL modules
test: add unit tests for transform functions
ci: add GitHub Actions cron workflow
```

---

## Pull request workflow

1. Branch from `develop` using the steps above
2. Make your changes
3. Commit using the Conventional Commits format
4. Push your branch and open a pull request into `develop`
5. Set a clear PR title following Conventional Commits
6. Add a short description of what changed and why
7. Request a review from the Project Lead
8. Once approved, the Project Lead merges

PRs into `main` are only accepted from `develop` and are handled by the Project Lead.

---

## Pre-commit checks

The following checks run automatically on every commit and push.

### On every commit

| Check | What it does |
|---|---|
| Branch name | Must follow `feature/`, `fix/`, `chore/`, `docs/`, `refactor/`, `test/`, `ci/` convention |
| `.env` guard | Blocks `.env` from being committed |
| Commit message | Must follow Conventional Commits format |
| Ruff linting | Python linting and formatting — auto-fixes where possible |
| Trailing whitespace | Removes trailing whitespace from all files |
| End of file | Ensures files end with a newline |
| Large files | Blocks files over 500KB |
| Secret detection | Scans for accidentally hardcoded credentials |

### On every push

| Check | What it does |
|---|---|
| Base branch | Branch must be based on `develop` — hard block |
| Direct push to main | Blocked entirely — raise a PR from `develop` |
| Behind develop | Warning if branch is behind `develop` — prompts to rebase |

---

## Fixing common errors

**Branch name error**
```bash
git branch -m feature/your-task-name
```

**Commit message error**
```bash
git commit -m "feat: your description here"
```

**.env accidentally staged**
```bash
git reset HEAD .env
```

**Branch not based on develop**
```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-task-name
```

**Ruff linting error** — ruff auto-fixes most issues with `--fix`. For anything it can't fix it will show the line number and rule ID. Google the rule ID for an explanation.

**Secret detected** — remove the hardcoded value, move it to `.env`, then update the baseline:
```bash
python3 -m detect_secrets scan > .secrets.baseline
```

**Branch behind develop warning**
```bash
git rebase origin/develop
```

**venv not active**
```bash
source venv/bin/activate
```

**pip or python command not found**
```bash
echo 'alias pip=pip3' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
source ~/.zshrc
```
