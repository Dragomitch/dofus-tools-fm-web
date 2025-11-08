# Git Branching Strategy

## Overview

This document defines the branching strategy for the Dofus Tools migration project. The strategy is designed to support wave-based development with multiple agents working in parallel while maintaining code quality and stability.

---

## Branch Naming Conventions

### Main Branches

| Branch | Purpose | Protection | Merging |
|--------|---------|-----------|---------|
| `main` | Production-ready code | Yes | PR + Code Review + Tests |
| `develop` | Integration branch for next release | Yes | PR + Code Review + Tests |

### Feature/Wave Branches

| Pattern | Purpose | Created From | Example |
|---------|---------|--------------|---------|
| `wave-X-[name]` | Wave implementation branches | `develop` | `wave-0-devops-setup` |
| `feature/[name]` | Individual feature implementation | Wave branch or `develop` | `feature/rune-repository` |
| `fix/[name]` | Bug fix branches | `develop` or `main` | `fix/string-matching-algorithm` |
| `refactor/[name]` | Refactoring work | `develop` | `refactor/api-structure` |
| `docs/[name]` | Documentation updates | `develop` | `docs/migration-guide` |

---

## Branch Hierarchy

```
main (production)
  └─ develop (integration)
      ├─ wave-0-devops-setup
      │  ├─ feature/gitignore-setup
      │  └─ feature/branch-protection
      │
      ├─ wave-1-backend-config
      │  ├─ feature/maven-dependencies
      │  └─ feature/app-properties
      │
      ├─ wave-2-data-models
      │  ├─ feature/rune-entity
      │  └─ feature/database-migration
      │
      └─ [additional wave branches]
```

---

## Naming Convention Rules

### Format
```
<type>/<wave-id>-<descriptor>

where:
  <type>     = wave | feature | fix | refactor | docs
  <wave-id>  = wave number (0-N) or feature scope
  <descriptor> = kebab-case, descriptive, max 50 characters
```

### Examples

**Wave Branches:**
- `wave-0-devops-setup`
- `wave-1-backend-configuration`
- `wave-2-data-models`
- `wave-3-repositories`

**Feature Branches:**
- `feature/wave0-gitignore-configuration`
- `feature/wave1-maven-dependencies`
- `feature/wave2-rune-entity`
- `feature/string-matching-service`

**Fix Branches:**
- `fix/rune-weight-calculation`
- `fix/database-migration-v1`

**Documentation Branches:**
- `docs/api-reference`
- `docs/setup-guide`

### Naming Rules

1. Use lowercase letters and numbers only
2. Use hyphens (-) to separate words (kebab-case)
3. Be descriptive but concise
4. Start with wave number when working on wave-specific tasks
5. Do not use underscores, spaces, or dots
6. Maximum length: 100 characters

**Invalid Examples:**
- `Wave-0-Setup` (mixed case)
- `wave_0_setup` (underscores)
- `wave-0-this-is-a-very-long-branch-name-that-exceeds-reasonable-limits` (too long)

---

## Wave-Based Development Strategy

### Wave Structure

Each wave represents a logical unit of work with clear dependencies and deliverables.

#### Wave 0: Foundation (Level 0 - No Dependencies)
- **Duration**: ~2-3 hours
- **Tasks**: DevOps setup, Project initialization
- **Branches**:
  - `wave-0-devops-setup` (this branch)
  - `wave-0-backend-initialization`
  - `wave-0-frontend-initialization`
  - `wave-0-documentation`
- **Parallel Execution**: All tasks can run simultaneously

#### Wave 1: Configuration (Level 1)
- **Duration**: ~8 hours
- **Dependencies**: Wave 0 must complete
- **Tasks**: Maven/npm dependencies, configuration files, project structure
- **Parallel Execution**: All backend and frontend tasks can run in parallel
- **Example Branches**:
  - `wave-1-backend-configuration`
  - `wave-1-frontend-configuration`

#### Wave 2+: Feature Development
- Subsequent waves follow same pattern
- Always depends on previous wave completion
- Frontend and backend work in parallel

### Wave Completion Criteria

A wave is considered complete when:

1. All tasks in the wave have merged PRs to `develop`
2. All tests pass (unit, integration, E2E where applicable)
3. Code review completed and approved
4. Documentation updated
5. No blocking issues remain
6. Ready for next wave to begin

---

## Merge Strategy

### Merge Workflow

```
Feature/Fix Branch → Pull Request → Code Review → Merge to Wave Branch →
  Wave Branch → Pull Request → Code Review → Merge to develop →
  Merge to main (Release Ready)
```

### Merge Types

#### Feature/Fix to Wave Branch
- **Condition**: Code review approved, tests pass
- **Merge Type**: Squash commit (for cleaner history)
- **Message Format**: `feat(wave-X): description` or `fix(wave-X): description`

#### Wave Branch to Develop
- **Condition**: All wave tasks complete, integration tested
- **Merge Type**: Merge commit (to preserve wave history)
- **Message Format**: `Merge branch 'wave-X-[name]' into develop`

#### Develop to Main
- **Condition**: Release planned, all features tested, documentation complete
- **Merge Type**: Merge commit
- **Tag Format**: `v[major].[minor].[patch]` (semantic versioning)
- **Message Format**: `Release: v[version]`

### Squash vs. Merge Commits

| Scenario | Merge Type | Reason |
|----------|-----------|--------|
| Feature to wave branch | Squash | Clean, single commit per feature |
| Wave to develop | Merge | Preserve wave completion milestone |
| Release to main | Merge | Track production releases |

---

## Branch Protection Rules

### Main Branch (`main`)
- Require pull request reviews before merging
- Require status checks to pass before merging (CI/CD)
- Require branches to be up to date before merging
- Require code review from at least 2 maintainers
- Dismiss stale PR approvals when new commits are pushed
- Require conversation resolution before merging

### Develop Branch (`develop`)
- Require pull request reviews before merging
- Require status checks to pass before merging
- Require branches to be up to date before merging
- Require code review from at least 1 maintainer
- Dismiss stale PR approvals when new commits are pushed

### Wave Branches
- No protection rules (allows fast development)
- Should still use PRs for feature merge (recommended)

---

## Commit Message Convention

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: A new feature
- `fix`: A bug fix
- `refactor`: Code refactoring without feature/fix
- `test`: Adding or updating tests
- `docs`: Documentation changes
- `style`: Formatting, missing semicolons, etc.
- `chore`: Dependency updates, build changes
- `perf`: Performance improvements

### Examples

```
feat(backend): implement rune repository with filtering

Added RuneRepository interface and JpaRepository implementation.
Supports filtering by category, name, and weight.

Closes #42
```

```
fix(frontend): correct string matching algorithm

Fixed off-by-one error in character occurrence calculation.
Now correctly handles multi-byte Unicode characters.

Fixes #38
```

---

## Workflow for Wave-Based Development

### For Individual Developers/Agents

1. **Create wave branch** (if not exists):
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b wave-X-[name]
   ```

2. **Create feature branch** from wave branch:
   ```bash
   git checkout wave-X-[name]
   git pull origin wave-X-[name]
   git checkout -b feature/[name]
   ```

3. **Work on feature**:
   ```bash
   git add .
   git commit -m "feat(scope): description"
   ```

4. **Push and create PR** to wave branch:
   ```bash
   git push origin feature/[name]
   # Create PR on GitHub: feature/[name] → wave-X-[name]
   ```

5. **After merge**, PR to develop:
   ```bash
   # Wave lead creates PR: wave-X-[name] → develop
   # After all tasks in wave complete
   ```

### For Wave Completion

1. All feature PRs merged to wave branch
2. Wave lead squashes and merges wave branch to develop
3. Create release tag on main (if releasing to production)

---

## Common Branching Scenarios

### Scenario 1: Work on Wave 2 Backend Features

```bash
# Clone/fetch latest
git checkout develop && git pull origin develop

# Create or checkout wave branch
git checkout -b wave-2-data-models

# Create feature branch for your task
git checkout -b feature/rune-entity

# After completing work
git push origin feature/rune-entity
# Create PR to wave-2-data-models
```

### Scenario 2: Hotfix on Main

```bash
# Create hotfix from main
git checkout main && git pull origin main
git checkout -b fix/critical-bug

# After fix complete
git push origin fix/critical-bug
# Create PR to main AND develop (to prevent regression)
```

### Scenario 3: Rebase and Sync

```bash
# Keep feature branch up to date with wave branch
git fetch origin
git rebase origin/wave-X-[name]

# Or merge if rebase conflicts are complex
git merge origin/wave-X-[name]
```

---

## Best Practices

1. **Keep branches short-lived** - Maximum 1-2 weeks per branch
2. **Frequent commits** - Commit logically related changes together
3. **Descriptive PR titles** - Use same format as commit messages
4. **Link issues** - Reference related issues in PR description
5. **Test before pushing** - Run tests locally before creating PR
6. **Update documentation** - Keep migration docs current
7. **Review promptly** - Code reviews should be done within 24 hours
8. **Communicate blocking issues** - Report blockers immediately to team
9. **Sync frequently** - Pull latest from wave/develop branches regularly
10. **Use semantic versioning** - For releases to main

---

## Troubleshooting

### Accidentally committed to develop

```bash
git reset HEAD~1                  # Undo last commit
git checkout -b feature/new-branch
git commit -m "..."
```

### Need to switch branches before PR

```bash
git stash                              # Save changes
git checkout other-branch
# Do work...
git checkout -
git stash pop                          # Restore changes
```

### Merge conflict resolution

```bash
git fetch origin
git merge origin/wave-X-[name]
# Resolve conflicts in editor
git add .
git commit -m "Merge branch 'wave-X-[name]' into feature/..."
```

### Remove local branch

```bash
git branch -d feature/old-branch       # Safe delete (won't delete if not merged)
git branch -D feature/old-branch       # Force delete
```

---

## References

- [Git Flow Model](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)

---

**Last Updated**: 2025-11-08
**Version**: 1.0
**Status**: Active
