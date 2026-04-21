## Summary

<!-- Brief description of changes (2-3 sentences) -->

## Related Issues

<!-- Link to related issues -->
- Closes #
- Related to #

## Type of Change

- [ ] **feat**: New feature (has spec: `docs/specs/[name].md`)
- [ ] **fix**: Bug fix (has post-mortem: `docs/bugs/BUG-[ID].md`)
- [ ] **docs**: Documentation only
- [ ] **spec**: Specification added/updated
- [ ] **test**: Tests added/updated
- [ ] **refactor**: Code refactoring (no feature change)
- [ ] **chore**: Maintenance tasks

## Specification

<!-- Link to spec if this is a feature -->
- Spec: `docs/specs/[feature-name].md`
- Review: `docs/reviews/[feature-name].md`

## Quality Gates Checklist

Gate names match `.claude/skills/review/SKILL.md` (the authoritative definition).

### Prototype Mode (5 essential — always required)

### Tests pass
- [ ] `npm run test` — 0 failures

### Lint clean
- [ ] `npm run lint` — 0 warnings
- [ ] TypeScript strict mode (no `any`)
- [ ] No `console.log` in production code

### All ACs met
- [ ] Every AC has a passing test
- [ ] Traceability matrix complete (all ✅)

### Responsive *(skip if N/A)*
- [ ] Tested at 320px
- [ ] Tested at 375px
- [ ] Tested at 768px
- [ ] Tested at 1024px
- [ ] Tested at 1440px
- [ ] Touch targets ≥ 44x44px

### Code review
- [ ] No dead code, hardcoded values, or boundary errors
- [ ] Error handling at system boundaries only
- [ ] Naming is clear; complex code has a one-line *why* comment

### Production Mode (adds 5 — skip for prototype)

### Performance
- [ ] Lighthouse score > 90
- [ ] No unnecessary re-renders
- [ ] Images optimized

### Accessibility *(skip if N/A)*
- [ ] Keyboard navigation works
- [ ] Screen reader labels present
- [ ] Color contrast passes

### Cross-browser *(skip if N/A)*
- [ ] Chrome
- [ ] Safari
- [ ] Firefox

### Build succeeds
- [ ] `npm run build` — 0 errors
- [ ] API calls wired to real endpoints
- [ ] Loading and error states display

### Security scan
- [ ] No XSS vulnerabilities
- [ ] Secrets only in env vars
- [ ] Input sanitized
- [ ] Auth checks on protected routes

## Traceability Matrix

| Criterion | Test File | Test Name | Status |
|-----------|-----------|-----------|--------|
| AC-001 | `[file]` | `[name]` | ✅ |
| AC-002 | `[file]` | `[name]` | ✅ |

## Testing Instructions

<!-- How to test this PR -->

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Screenshots *(if UI changes)*

<!-- Before/after screenshots -->

| Before | After |
|--------|-------|
| [img] | [img] |

---

## Reviewer Notes

<!-- Any notes for reviewers -->
