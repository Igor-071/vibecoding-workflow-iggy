# Skill: Ship (PR + Deploy)

Activate when: User says "commit", "push", "ship it", "create PR", or similar.

## Commit

1. Stage only relevant files (never `git add .` blindly)
2. Use conventional commit format:
   ```
   feat(scope): add user authentication flow
   fix(scope): prevent crash on empty input
   test(scope): add login acceptance tests
   docs(scope): update API documentation
   refactor(scope): extract validation logic
   ```
3. Commit message = WHY, not WHAT. The diff shows what changed.

## Pull Request

Create with `gh pr create` using this structure:

```markdown
## Summary
- [1-3 bullet points of what this PR does]

## Acceptance Criteria
- [x] AC-001: [description] — tested
- [x] AC-002: [description] — tested

## Quality Gates
- [x] Tests passing (X/X)
- [x] Lint clean
- [x] All ACs covered by tests
- [x] Responsive check passed
- [x] Code reviewed

## How to Test
1. [Step-by-step manual verification]

## Spec
Link to `docs/specs/[feature].md`
```

## Rules
- Never push without explicit user instruction
- Never force push
- Never push to main/master directly
- PR title < 70 chars. Details go in the body.
- Reference the spec. The spec is the source of truth.

## Parallel Shipping (Advanced)

When running multiple features in parallel with git worktrees:

```bash
# List active worktrees
git worktree list

# Each worktree has its own branch — push each independently
git push -u origin feature-branch-name
```

Never merge worktree branches without user approval.
