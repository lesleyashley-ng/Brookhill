# Contributing to Brookhill

Thanks for contributing. Please read this before starting any work.

New contributors must sign a **Contributor Agreement** before committing any code. See `docs/contributor-agreement.docx` and contact the Project Lead to get set up.

---

## Setting up your environment

### 1. Clone the repo and install dependencies

```bash
git clone https://github.com/[org]/brookhill.git
cd brookhill
pip install -r requirements.txt
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
# Rename your branch
git branch -m feature/your-task-name
```

**Commit message error**
```bash
# Use the correct format
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
