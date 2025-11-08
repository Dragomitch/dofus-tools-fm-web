# Git Workflow & Code Review Process

## Overview

This document outlines the workflow for contributing to the Dofus Tools migration project, including commit message conventions, pull request process, code review requirements, and wave completion criteria.

---

## Commit Message Conventions

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Components

#### Type (Required)
```
feat      - A new feature
fix       - A bug fix
refactor  - Code refactoring (no feature/fix)
test      - Adding or updating tests
docs      - Documentation changes only
style     - Formatting, semicolons, spacing (no code logic change)
chore     - Dependency updates, build scripts
perf      - Performance improvements
ci        - CI/CD pipeline changes
```

#### Scope (Optional but Recommended)
Logical area of the codebase:
```
backend, frontend, database, api, ui, migration, docs
backend-entity, frontend-service, database-migration
```

#### Subject (Required)
- Maximum 50 characters
- Use imperative mood ("add" not "added" or "adds")
- Do not capitalize first letter
- No period at end
- Clear and descriptive

#### Body (Optional for small changes, Required for complex changes)
- Wrap at 72 characters
- Explain WHAT and WHY, not HOW
- Separate from subject with blank line
- Multiple paragraphs allowed (separated by blank lines)

#### Footer (Optional)
- Reference issues: `Closes #42`, `Fixes #38`
- Reference PRs: `Relates to PR #100`
- Breaking changes: `BREAKING CHANGE: description`

### Examples

#### Example 1: Simple Feature
```
feat(backend): create rune repository interface

Create the RuneRepository interface extending JpaRepository.
Supports filtering by category and searching by name.

Closes #42
```

#### Example 2: Bug Fix
```
fix(frontend): correct string matching algorithm

Fixed off-by-one error in character occurrence count.
The algorithm was not properly handling empty strings.

Now correctly validates input before processing.
Added unit tests to prevent regression.

Fixes #38
```

#### Example 3: Documentation
```
docs: update branching strategy with wave examples

Added detailed examples for wave-based branch naming.
Included troubleshooting section for common git scenarios.
```

#### Example 4: Refactoring
```
refactor(backend): simplify weight calculation logic

Extracted weight calculation to dedicated method.
Improved readability and testability without changing behavior.
```

#### Example 5: Dependency Update
```
chore: upgrade spring boot to 3.2.1

Updates Spring Boot from 3.2.0 to 3.2.1.
Includes security patches and bug fixes.

Closes #99
```

### Commit Guidelines

1. **Atomic commits** - Each commit should be a logical unit
2. **Frequent commits** - Commit after completing a logical unit
3. **Test before committing** - Ensure code builds and tests pass
4. **Write meaningful messages** - Future developers will thank you
5. **No "WIP" commits** - Use git stash or branches for work in progress
6. **Link to issues** - Always reference related issues in footer

### Bad Commit Messages (Avoid)

```
❌ "stuff"
❌ "Fixed bug"
❌ "work in progress"
❌ "changes"
❌ "update files"
❌ "asdfgh"
❌ "Implemented feature ABCDEF based on requirements 1234"
```

### Good Commit Messages (Follow)

```
✅ "feat(backend): implement rune weight calculator"
✅ "fix(frontend): handle null rune categories gracefully"
✅ "test(backend): add integration tests for repository"
✅ "docs: update API documentation with examples"
✅ "refactor(database): optimize migration script"
```

---

## Pull Request Process

### Step 1: Create Pull Request

#### Before Creating PR
- [ ] Branch created from correct base (wave branch or develop)
- [ ] Code is tested locally
- [ ] Commit messages follow convention
- [ ] No unnecessary whitespace changes
- [ ] Documentation updated (if applicable)

#### PR Title Format
```
<type>(<scope>): <description>

Examples:
- feat(backend): implement rune repository
- fix(frontend): correct string matching algorithm
- docs: add deployment guide
```

#### PR Description Template
See [PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md)

### Step 2: Automated Checks

The following checks must pass before review:

- [ ] **CI/CD Pipeline**: All builds successful
  - Backend: Maven build, unit tests, integration tests
  - Frontend: npm build, linting, unit tests
  - Security: Dependency scanning, vulnerability checks

- [ ] **Code Quality**:
  - No new code smells (SonarQube/similar)
  - Adequate test coverage (>80% for new code)
  - No security vulnerabilities

- [ ] **Code Style**:
  - Formatting standards met (Prettier/Spotless)
  - Linting passes (ESLint/Checkstyle)
  - No trailing whitespace

### Step 3: Code Review

#### Review Responsibilities

**Reviewer** must check:
1. Code follows project conventions
2. Logic is correct and efficient
3. Tests adequately cover changes
4. Documentation is clear and complete
5. No security issues
6. Breaking changes are documented

**Author** must:
1. Respond to all comments
2. Make requested changes
3. Request re-review after changes
4. Be open to feedback

#### Code Review Checklist

- [ ] Code is understandable and maintainable
- [ ] Changes are logically grouped
- [ ] Tests cover new functionality
- [ ] Documentation updated
- [ ] No hardcoded values
- [ ] Error handling implemented
- [ ] Performance impact considered
- [ ] Security implications addressed
- [ ] Backward compatibility maintained (or breaking changes documented)
- [ ] Integration with other components checked

#### Approval Levels

| Branch | Required Approvals | Expedited | Notes |
|--------|-------------------|-----------|-------|
| main | 2 (codeowners) | No | Highest standard |
| develop | 1 (codeowner) | No | Most changes here |
| wave-* | 1 (peer) | Yes | Fast iteration |
| feature/* | 0 (optional) | N/A | Optional for branches |

#### Common Review Comments

**Request Changes**
```
If fundamental issues found:
- Architecture problems
- Security vulnerabilities
- Test failures
- Breaking changes without documentation
```

**Comment**
```
For minor improvements:
- Code style suggestions
- Documentation improvements
- Refactoring opportunities
```

**Approve**
```
When all requirements met:
- Code quality acceptable
- Tests adequate
- Documentation complete
- No blocking issues
```

### Step 4: Merge

#### Pre-Merge Checklist
- [ ] All conversations resolved
- [ ] All required reviews approved
- [ ] All CI checks passing
- [ ] Branch up to date with base branch
- [ ] Commit message follows convention

#### Merge Strategy

**Feature to Wave Branch**: Squash merge
```bash
git merge --squash feature/[name]
git commit -m "feat(wave-X): description"
```

**Wave to Develop**: Merge commit
```bash
git merge --no-ff wave-X-[name]
```

**Develop to Main**: Merge commit with tag
```bash
git merge --no-ff develop
git tag -a v1.0.0 -m "Release v1.0.0"
```

### Step 5: Post-Merge

- [ ] Monitor for any issues in develop branch
- [ ] Update issue/ticket status
- [ ] Close related pull requests
- [ ] Update project documentation
- [ ] Announce in team channels if significant change

---

## Code Review Standards

### Backend Code Review (Java/Spring Boot)

**Checklist**:
- [ ] Follows Spring Boot best practices
- [ ] Proper dependency injection used
- [ ] Database transactions properly defined
- [ ] Error handling with appropriate exceptions
- [ ] Logging at appropriate levels (info, warn, error)
- [ ] No n+1 queries
- [ ] Proper validation of inputs
- [ ] Unit tests with >80% coverage
- [ ] Integration tests for DB/API changes
- [ ] Documentation comments for public APIs
- [ ] No hardcoded values

**Common Issues**:
- Missing @Transactional annotations
- Lazy loading without proper handling
- Insufficient error handling
- Missing validation
- Poor exception messages

### Frontend Code Review (TypeScript/Angular)

**Checklist**:
- [ ] Follows Angular style guide
- [ ] Components have single responsibility
- [ ] Proper service injection and usage
- [ ] Input validation on forms
- [ ] Proper error handling and user feedback
- [ ] Accessibility standards met (a11y)
- [ ] Unit tests with >80% coverage
- [ ] No hardcoded URLs or values
- [ ] Proper TypeScript typing (no 'any')
- [ ] Performance: no unnecessary re-renders
- [ ] Responsive design tested

**Common Issues**:
- Missing 'trackBy' in ngFor loops
- Unsubscribe from observables (memory leaks)
- Missing error boundaries
- No loading states
- Hard-coded API URLs

### Database Review (SQL/Migrations)

**Checklist**:
- [ ] Migration has descriptive name
- [ ] Rollback/down migration defined
- [ ] No breaking changes without migration path
- [ ] Proper indexes on foreign keys
- [ ] Sensible default values
- [ ] Constraints properly defined
- [ ] Migration tested on fresh database
- [ ] Data integrity preserved

---

## Wave Completion Criteria

### Definition

A wave is considered **complete** and ready to merge to develop when:

### Mandatory Criteria (Must Have)
1. **All tasks merged** - Every task in wave task list has merged PR
2. **Tests passing** - 100% of automated tests pass
   - Unit tests
   - Integration tests
   - E2E tests (if applicable)
3. **Code review approved** - All PRs reviewed and approved
4. **Documentation complete**
   - Updated migration progress
   - Implementation details documented
   - Breaking changes noted
5. **No open issues** - All blocking issues resolved
6. **Code quality gate** - Passes quality thresholds
   - SonarQube rating A or better
   - Test coverage >80%
   - No security vulnerabilities

### Recommended Criteria (Should Have)
1. **Performance testing** - No regressions from baseline
2. **Security review** - Security best practices followed
3. **Architecture review** - Design decisions documented
4. **Team sign-off** - Wave lead confirms readiness

### Validation Checklist

```markdown
## Wave X Completion Checklist

- [ ] All tasks from task matrix completed
- [ ] All feature branches merged to wave branch
- [ ] Wave branch PR created to develop
- [ ] All automated tests passing (100%)
- [ ] Code review approvals obtained (by codeowners)
- [ ] Migration documentation updated
- [ ] API documentation (if applicable) updated
- [ ] Architecture decisions documented
- [ ] No known bugs or open issues
- [ ] Security review passed
- [ ] Performance baselines met
- [ ] Wave lead sign-off obtained

**Wave Lead**: [Name]
**Date Completed**: [Date]
**Merge Commit**: [Hash]
```

### Escalation Procedure

If wave cannot meet completion criteria:

1. **Identify blockers** - Document what prevents completion
2. **Assess impact** - Determine if next wave can proceed
3. **Report to team** - Update status in team channels
4. **Plan remediation** - Schedule fix with responsible parties
5. **Document decision** - Record in wave completion notes

---

## Handling Edge Cases

### Case 1: Bug Found During Review

**Action**:
1. Author fixes issue with new commit
2. Request re-review
3. Do NOT approve until re-reviewed

### Case 2: Blocking Issue Discovered

**Action**:
1. Document issue in PR comments
2. Do NOT merge
3. Escalate to wave lead
4. Plan remediation in separate PR if needed

### Case 3: Need Changes After Approval

**Action**:
1. Make changes in new commits
2. Request re-review if changes are significant
3. Can merge if changes are minor (typos, formatting)

### Case 4: Conflicting PRs from Multiple Agents

**Action**:
1. First PR to merge gets priority
2. Other PR authors rebase on updated base
3. Re-run tests and get re-approval
4. Merge in sequential order

### Case 5: Cannot Complete Task Within Wave

**Action**:
1. Move task to next wave (if no dependencies)
2. Or mark as blocked with reason
3. Update wave completion status
4. Document impact on downstream tasks

---

## Tools & Automation

### GitHub Actions / CI/CD
- Automated testing on every PR
- Code quality scanning
- Security scanning
- Dependency updates (Dependabot)
- Automated deployment to staging

### Pre-commit Hooks
```bash
# Install
npm install husky lint-staged --save-dev
npx husky install

# Runs linters on staged files before commit
# Prevents committing code that fails style checks
```

### IDE Integration
- ESLint (frontend)
- Spotless/Checkstyle (backend)
- Prettier (formatting)
- SonarLint (code quality)

---

## FAQ

**Q: Can I merge my own PR?**
A: No, always require review from another team member.

**Q: How long should code review take?**
A: Target is 24 hours. Expedited reviews available for blocking issues.

**Q: What if reviewer disappears?**
A: Wave lead can reassign review or provide alternative reviewer.

**Q: Can I rebase develop branch?**
A: No, only rebase feature branches. Develop should have clean history.

**Q: What about emergency hotfixes?**
A: Create from main, merge to main AND develop immediately after.

**Q: Can I force push to develop?**
A: Absolutely not. Force push only on your own feature branches.

---

## References

- [Branching Strategy](./BRANCHING_STRATEGY.md)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Google commit message guide](https://google.github.io/styleguide/shellstyle.md#comments-and-documentation)
- [Task Execution Matrix](./TASK_EXECUTION_MATRIX.md)

---

**Last Updated**: 2025-11-08
**Version**: 1.0
**Status**: Active
